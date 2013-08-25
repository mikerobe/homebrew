require 'formula'

class MpcMultiprecision < Formula
  url 'http://www.multiprecision.org/mpc/download/mpc-0.9.tar.gz'
  homepage 'http://www.multiprecision.org/index.php?prog=mpc&page=download'
  sha1 '229722d553030734d49731844abfef7617b64f1a'

  depends_on 'pkg-config' => :build
  depends_on 'libmpdclient'

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make install"
  end
end
