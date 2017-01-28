require 'formula'

class Ab < Formula
  homepage 'http://httpd.apache.org/docs/trunk/programs/ab.html'
  url 'http://archive.apache.org/dist/httpd/httpd-2.4.9.tar.bz2'
  sha256 '3e62175b6e4c756671e493a863cccfd0ffaf0ef86c7eeb6f7f8f486dd51602e1'

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
