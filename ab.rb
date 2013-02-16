require 'formula'

class Ab < Formula
  homepage 'http://httpd.apache.org/docs/trunk/programs/ab.html'
  url 'http://archive.apache.org/dist/httpd/httpd-2.4.3.tar.bz2'
  sha1 '0ef1281bb758add937efe61c345287be2f27f662'

  depends_on 'pcre'
  depends_on 'libtool'

  def install
    ENV['LTFLAGS'] = '--tag CC'
    system './configure',
      '--prefix=#{prefix}',
      '--disable-debug',
      '--disable-dependency-tracking'

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
