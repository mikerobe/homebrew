require 'formula'

class Libmatroska < Formula
  homepage 'http://www.matroska.org/'
  url 'http://dl.matroska.org/downloads/libmatroska/libmatroska-1.3.0.tar.bz2'
  mirror 'http://www.bunkus.org/videotools/mkvtoolnix/sources/libmatroska-1.3.0.tar.bz2'
  sha1 '81c5a812604c0f05c471230e05b8cbc4542226fc'

  depends_on 'libebml'

  def install
    ENV['CXX'] = 'g++-4.7'
    ENV['CC'] = 'gcc-4.7'
    ENV['LD'] = 'gcc-4.7'
    ENV['CXXFLAGS'] = '-Os -Wall -Wextra -pipe -Woverloaded-virtual -std=c++11'
    ENV['CFLAGS'] = '-Wall -Wextra -pipe'

    cd 'make/linux' do
      system "make", "install", "prefix=#{prefix}", "CXX=#{ENV.cxx}",
          'CXXFLAGS=-std=c++11'
    end
  end
end
