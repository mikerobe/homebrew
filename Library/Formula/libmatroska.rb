require 'formula'

class Libmatroska < Formula
  homepage 'http://www.matroska.org/'
  url 'http://dl.matroska.org/downloads/libmatroska/libmatroska-1.4.0.tar.bz2'
  mirror 'http://www.bunkus.org/videotools/mkvtoolnix/sources/libmatroska-1.4.0.tar.bz2'
  sha256 '1b6d02e75cdbfb6d282dcf2a902a259c3075404885d5e8063e6652a2b3f6c11b'

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
