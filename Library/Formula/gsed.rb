require 'formula'

class Gsed < Formula
  url 'http://ftpmirror.gnu.org/sed/sed-4.2.tar.gz'
  homepage 'http://www.gnu.org/software/sed/'
  md5 '31580bee0c109c0fc8f31c4cf204757e'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end

  def test
    system "#{bin}/gsed --version"
  end
end
