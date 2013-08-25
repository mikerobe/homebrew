require 'formula'

class Less < Formula
  url 'http://ftpmirror.gnu.org/less/less-443.tar.gz'
  homepage 'http://www.gnu.org/software/less'
  md5 '47db098fb3cdaf847b3c4be05ee954fc'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end

  def test
    system "#{bin}/less"
  end
end
