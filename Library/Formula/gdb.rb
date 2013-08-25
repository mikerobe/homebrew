require 'formula'

class Gdb < Formula
  homepage 'http://www.gnu.org/software/gdb/'
  url 'http://ftpmirror.gnu.org/gdb/gdb-7.4.tar.bz2'
  mirror 'http://ftp.gnu.org/gnu/gdb/gdb-7.4.tar.bz2'
  md5 '95a9a8305fed4d30a30a6dc28ff9d060'

  def install
    args = ["--prefix=#{prefix}",
            "--sysconfdir=#{etc}",
            "--with-ssl=openssl"]

    system "./configure", *args
    system "make"
    system "make install"
  end
end
