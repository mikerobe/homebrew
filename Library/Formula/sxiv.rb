require 'formula'

class Sxiv < Formula
  homepage 'https://github.com/muennich/sxiv.git'
  head 'https://github.com/muennich/sxiv.git'

  depends_on :x11
  depends_on 'imlib2'
  depends_on 'giflib'

  def patches
    "https://raw.github.com/gist/3426694/7a0e91e794606d4344e480ca93199316b1979c71/sxiv_patch.patch"
  end

  def install
    ENV['DESTDIR'] = prefix
    system "make"
    system "make install"
    bin.install "sxiv"
    man1.install gzip("sxiv.1")
  end
end
