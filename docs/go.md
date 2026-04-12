### [Modview](https://github.com/bayraktugrul/modview)
- Download and compile
```bash
git clone https://github.com/bayraktugrul/modview
cd modview
go build -mod=readonly -trimpath -ldflags="-s -w" -o modview main.go
```
- Run `modview && firefox --private-window dependency_tree.html`
