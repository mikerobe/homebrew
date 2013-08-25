require 'formula'

class Grep < Formula
  url 'http://ftpmirror.gnu.org/grep/grep-2.9.tar.xz'
  mirror 'http://ftp.gnu.org/gnu/grep/grep-2.9.tar.xz'
  homepage 'http://www.gnu.org/software/grep/'
  md5 '25e41b2aa201104354740961ef36005a'

  def options
    [['--default-names', "Do NOT prepend 'g' to the binary; will override system tar."]]
  end

  def install
    args = [ "--prefix=#{prefix}" , "--mandir=#{man}" ]
    args << "--program-prefix=g" unless ARGV.include? '--default-names'

    system "./configure", *args
    system "make install"
  end
end
