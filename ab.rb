require 'formula'

class Ab < Formula
  homepage 'http://httpd.apache.org/docs/trunk/programs/ab.html'
  url 'http://archive.apache.org/dist/httpd/httpd-2.4.9.tar.bz2'
  sha256 'f78cc90dfa47caf3d83ad18fd6b4e85f237777c1733fc9088594b70ce2847603'

  depends_on 'pcre'
  depends_on 'libtool'

  def install
    ENV['LTFLAGS'] = '--tag CC'

    system './configure', "--prefix=#{prefix}", '--disable-debug', '--disable-dependency-tracking'

    cd 'support' do
      system 'make ab'
      bin.install('ab')
    end

    man1.install('docs/man/ab.1')
  end

  def test
    puts `"#{bin}/ab" -k -n 10 -c 10 http://www.apple.com/`
  end
end
