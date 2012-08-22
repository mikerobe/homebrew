require 'formula'

class Mkvtoolnix < Formula
  url 'http://www.bunkus.org/videotools/mkvtoolnix/sources/mkvtoolnix-5.7.0.tar.bz2'
  sha1 'c0ec30ef79435b287d52253abe45b105c77434ce'
  head 'https://github.com/mbunkus/mkvtoolnix.git'
  homepage 'http://www.bunkus.org/videotools/mkvtoolnix/'

  depends_on 'boost'
  depends_on 'libvorbis'
  depends_on 'libebml'
  depends_on 'libmatroska'
  depends_on 'flac' => :optional
  depends_on 'lzo' => :optional

  fails_with :clang do
    build 318
  end

  def install
    ENV['CXX'] = 'g++-4.7'
    ENV['CC'] = 'gcc-4.7'
    ENV['LD'] = 'gcc-4.7'
    ENV['CXXFLAGS'] = '-Os -Wall -Wextra -pipe -Woverloaded-virtual -std=c++11'
    ENV['CFLAGS'] = '-Wall -Wextra -pipe'

    system "./configure",
                          "CXXFLAGS=-std=c++11",
                          "--disable-debug",
                          "--prefix=#{prefix}",
                          "--with-boost-libdir=#{HOMEBREW_PREFIX}/lib", # For non-/usr/local prefix
                          "--with-boost-regex=boost_regex-mt" # via macports
    system "./drake", "-j#{ENV.make_jobs}"
    system "./drake install"
  end
end
