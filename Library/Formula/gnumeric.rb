require 'formula'

class Gnumeric < Formula
  homepage 'http://projects.gnome.org/gnumeric/'
  url 'http://ftp.gnome.org/pub/GNOME/sources/gnumeric/1.11/gnumeric-1.11.3.tar.xz'
  sha256 'e2f00e4753e8dfe95b7a98a6c254b1c23dca9835303692805ff463a2d66274c1'

  depends_on 'pkg-config' => :build
  depends_on 'gettext'
  depends_on 'intltool'
  depends_on 'goffice'
  depends_on 'rarian'

  def install
    system "CFLAGS=-Wformat-security",
        "./configure", "--disable-dependency-tracking",
        "--prefix=#{prefix}"
    system "make install"
  end
end
