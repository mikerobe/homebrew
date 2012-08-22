require 'formula'

class Vim < Formula
  head 'https://vim.googlecode.com/hg/vim', :using => :hg
  homepage 'http://www.vim.org'

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--enable-cscope",
                          "--enable-conceal",
                          "--enable-rubyinterp",
                          "--enable-python3interp=yes",
                          "--enable-pythoninterp=yes",
                          "--enable-perlinterp=yes",
                          "--enable-multibyte"
                          "--with-features=huge"
    system "make install"
  end

  def patches
      "https://retracile.net/raw-attachment/blog/2011/08/23/21.30/vim-7.3.285-breakindent.patch"
  end

  def test
    system "#{bin}/vim"
  end
end
