require 'formula'

class Gcc < Formula
  url 'http://ftp.gnu.org/gnu/gcc/gcc-4.7.0/gcc-4.7.0.tar.bz2'
  homepage 'http://gcc.gnu.org/'
  sha1 '03b8241477a9f8a34f6efe7273d92b9b6dd9fe82'

  depends_on 'gmp'
  depends_on 'mpfr'
  depends_on 'mpc_multiprecision'

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make install"
  end

  def test
    system "#{bin}/gcc"
  end
end
