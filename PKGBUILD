pkgname=autodarts-client-arch-launcher
pkgver=1.0
pkgrel=1
arch=('any')
pkgdesc="Launcher for Autodarts Client for Arch Linux"
depends=('xdg-utils' 'systemd' 'curl' 'polkit')
license=('custom')
source=('autodarts-client-arch-launcher.sh'
        'autodarts.desktop'
        'autodarts_icon.png'
        '50-autodarts.rules')
md5sums=('SKIP'
         'SKIP'
         'SKIP'
         'SKIP')

package() {
  install -Dm755 "$srcdir/autodarts-client-arch-launcher.sh" "$pkgdir/usr/bin/autodarts-launcher"
  install -Dm644 "$srcdir/autodarts.desktop" "$pkgdir/usr/share/applications/autodarts.desktop"
  install -Dm644 "$srcdir/autodarts_icon.png" "$pkgdir/usr/share/icons/hicolor/128x128/apps/autodarts.png"
  install -Dm644 "$srcdir/50-autodarts.rules" "$pkgdir/etc/polkit-1/rules.d/50-autodarts.rules"
}
