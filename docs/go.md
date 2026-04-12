### [Modview](https://github.com/bayraktugrul/modview)
- Download and compile
```bash
git clone https://github.com/bayraktugrul/modview
cd modview
go build -mod=readonly -trimpath -ldflags="-s -w" -o modview main.go
```
- Run `modview && firefox --private-window dependency_tree.html`
- Optional. Dark mode setup
```bash
#!/usr/bin/env bash
set -e
outfile=dependency_tree.html

modview
if ! [ -f $outfile ]; then
    echo "Error! No file generated"
    exit 1
fi

ln=$(grep -n '</body>' $outfile | cut -d: -f1)
sed -i "${ln}i "'<script>document.getElementById("dark-mode-toggle").click();</script>' $outfile
firefox --private-window $outfile
```
