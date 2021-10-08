# golang-dev

How to setup golang development environment on Ubuntu.

golang-go について、公式のインストール方法は下記にあります。リポジトリからインストールする方法がありますが、最新にはならないので、VSCode を使う時に拡張機能で警告が表示されてしまいます。

- [Ubuntu · golang/go Wiki · GitHub](https://github.com/golang/go/wiki/Ubuntu)

バージョンの切り替えについては公式の方法があるので、tar.gz 版をインストールするのが王道になります。ただ、anyenv、goenv の環境下で開発をしている場合もあるので、そちらにも対応ができるようにしておきたいところです。また、apt 版でインストールした環境にも対応できた方が良さそうです。

開発には Visual Studio Code (VSCode) を使うことも多いので、その環境でも問題ないような設定をしたいですね。

ということで検討した結果、現時点だと下記で良さそうです。

- $HOME/app/go に tar.gz 版をインストール
- $HOME/.profile で `$PATH` を指定
- $HOME/.profile で `$GOPATH` を指定
- goenv は anyenv でインストール
- goenv で普段使うものは system （`goenv global system` で指定したもの）
- goenv 環境で開発しているものは .go-version （`goenv local` で指定したもの）
- apt 版を使う場合は専用スクリプトを用意して利用

$HOME/.profile へは下記の内容を追加します。ここでは anyenv を利用する場合の指定例になります。

```sh
export ANYENV_ROOT="$HOME/.anyenv"
export PATH="$ANYENV_ROOT/bin:$HOME/app/go/bin:$PATH"
export GOPATH="$HOME/go/system"

eval "$(anyenv init -)"
```

goenv の system で使うための golang-go のインストールは $HOME/app/go にします。goenv の GOPATH に合わせるために、GOPATH は $HOME/go/system を指定するようにします。ここでは、あらかじめ go1.17.2.linux-amd64.tar.gz を ~/Downloads へ取得しているとします。

```console
mkdir -p $HOME/app/
cd $HOME/app
tar xf ~/Downloads/go1.17.2.linux-amd64.tar.gz
mkdir -p $HOME/go/system
export GOPATH="$HOME/go/system"
```

goenv と、goenv 環境の golang-go 指定バージョンのインストールは次のようにします。ここでは 1.15.15 をインストールしています。

```console
anyenv install goenv
goenv install 1.15.15
goenv global system
mkdir ~/workspace/go/1.15.15
cd ~/workspace/go/1.15.15
goenv local 1.15.15
```

Ubuntu では公式リポジトリがあるので、apt パッケージ版は次の手順でインストールができます。パッケージ版を使いたい場合は、パッケージ版をインストールしてから $HOME/bin/go-apt.sh を用意して使えば良いです。なお、VSCode では、この環境を使うことは想定していません。apt 版の動作確認をしたいときに使うことを想定しています。もし apt 版の go のバージョンでアプリを開発をしたい場合は apt 版と同じバージョンを goenv なり、公式版なりで用意して対応すれば良いはずです。

```console
sudo add-apt-repository ppa:longsleep/golang-backports
sudo apt update
sudo apt install golang-go
mkdir -p ~/go/apt-system
```

go-apt.sh 例は script/go-apt.sh にあります。$HOME/bin などにおいて、次のように使用します。

```console
$ chmod 755 ~/bin/go-apt.sh
$ PATH=$HOME/bin:$PATH
$ go-apt.sh version
go version go1.17.1 linux/amd64
```
