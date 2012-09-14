require 'formula'

class Libebml < Formula
  homepage 'http://www.matroska.org/'
  url 'http://dl.matroska.org/downloads/libebml/libebml-1.2.2.tar.bz2'
  mirror 'http://www.bunkus.org/videotools/mkvtoolnix/sources/libebml-1.2.2.tar.bz2'
  sha1 'f8ef2e044b79b6e4f777b20c0e0e2382c16fbafc'

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
