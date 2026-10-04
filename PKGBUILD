pkgname=autodarts-client-arch-launcher
pkgver=2.0.0
pkgrel=1
arch=('any')
pkgdesc="Launcher for the Autodarts v2 headless terminal app on Arch Linux"
depends=('bash' 'xdg-utils' 'systemd' 'curl' 'tar' 'gzip')
license=('custom')
source=('autodarts-client-arch-launcher.sh'
        'autodarts.desktop'
        'autodarts_icon.png')
md5sums=('SKIP'
         'SKIP'
         'SKIP')

package() {
  install -Dm755 "$srcdir/autodarts-client-arch-launcher.sh" "$pkgdir/usr/bin/autodarts-launcher"
  install -Dm644 "$srcdir/autodarts.desktop" "$pkgdir/usr/share/applications/autodarts.desktop"
  install -Dm644 "$srcdir/autodarts_icon.png" "$pkgdir/usr/share/icons/hicolor/128x128/apps/autodarts.png"
}
