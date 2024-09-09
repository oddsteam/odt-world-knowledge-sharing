# ODT World

## Development

### Nix

If you are using nix compatible environment like Linux, macOS, Windows WSL2, you can try `nix` to control development environment. For more information, visit [Play Nix](https://github.com/chonla/play-nix).

### Migrate World Data

In development environment, I have provided some mock data which can be imported into development database.

```bash
./bin/rails db:seed
```

More detail about nix, visit [nixos.org](https://nixos.org/).

### Sign in with Google

```ini
GOOGLE_CLIENT_ID=<google client id from google console>
GOOGLE_CLIENT_SECRET=<google client secret from google console>
ALLOWED_DOMAINS=odds.team
```