require 'formula'

class Vim < Formula
  head 'https://vim.googlecode.com/hg/vim', :using => :hg
  homepage 'http://www.vim.org'

  def install
    system "./configure", "--prefix=#{prefix}", "--enable-cscope",
                          "--enable-rubyinterp",
                          "--enable-python3interp=yes",
                          "--enable-perlinterp=yes"
    system "make install"
  end

  def test
    system "#{bin}/vim"
  end
end
