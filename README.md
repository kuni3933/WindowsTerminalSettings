# WindowsTerminalSettings

tadashi-aikawa様のowl-playbookをベースに個人的に改造したもの
<li><a href="https://github.com/tadashi-aikawa/owl-playbook">tadashi-aikawa/owl-playbook: Playbook both Linux and Windows for me</a></li>

## 1.以下からMicrosoft.DesktopAppInstaller(winget)とvoltaをインストール

<ul>
  <li><a href="https://github.com/microsoft/winget-cli/releases">Releases · microsoft/winget-cli</a></li>
  <li><a href="https://github.com/volta-cli/volta/releases">Releases · volta-cli/volta</a></li>
適切なバージョンをインストールして、<a href="https://qiita.com/naoyukik/items/d6a11808338a494238db">Nodeのバージョン管理ツールVOLTA⚡</a>を参考にnode-js等をインストール
</ul>

## 2.Gitのインストール・本リポジトリの配置

以下のコマンドを実行

1. <code>Windows Powershellを管理者権限で開く</code>
2. <code>winget install -e --id Git.Git</code>
3. <code>cd $env:USERPROFILE</code>
4. <code>git clone git@github.com:kuni3933/WindowsTerminalSettings.git --recursive</code>

## 3.Windows Terminal Preview(WTP)・PowerShellCore(pwsh)・VSCode・VSCode-Insidersのインストール

1. <code>pwshを管理者権限で開く</code>
2. <code>Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force</code><br>
3. <code>WindowsTerminalSettings/windows/winget/install.ps1</code><br>
  を実行して、Git・WTP・pwsh・VSCode・VSCode-Insidersの5つをインストール


## 4.パス設定

1. Gitがインストールされたフォルダを、システム環境変数:GIT_INSTALL_ROOT として登録


    まずは以下のコマンドを実行してgit.exeの位置を確認

    <code>cmd /c where git</code><br>

   出力された位置の2階層上に位置するGitフォルダを環境変数GIT_INSTALL_ROOTとして登録する.

    <code>C:\Program Files\Git\cmd\git.exe</code>と出力されたら以下の設定<br>
    <code>システム環境変数名:GIT_INSTALL_ROOT</code><br>
    <code>システム環境変数値:C:\Program Files\Git</code><br>

## 5.依存packageインストール



<code>windows/install.ps1</code>を管理者権限で実行.

| ディレクトリ | 概要                                                            |
| ------------ | --------------------------------------------------------------- |
| 1.PSGallery  | PSGalleryでインストールするもの                                 |
| 2.winget     | wingetでインストールするもの                                    |
| 3.scoop      | Scoopでインストールするもの                                     |
| 4.volta/npm  | volta/npmでインストールするもの                                 |
| 5.go         | goでインストールするもの                                        |
| 6.cargo      | rustでインストールするもの                                      |
| 7.ubuntu     | WSL2-Ubuntu-20.04 LTSでインストールするもの(wsl2準備段階で使用) |

初インストールの場合は、install.ps1を実行後
<ul>
<li>Keypirinha</li>
<li>VScode</li>
<li>pwsh</li>
</ul>
を一回起動して閉じたあとに再度windows/install.ps1を実行.

## 6.windows/provision.batをコマンドラインから管理者権限で実行

※install.ps1にしたがわないでgitをインストールする場合は、windows/provision.batのgitconfigコピー処理を消してから実行する※

## 7.定期アップデート

インストール後に更新ファイルがあった場合は以下の作業をする必要があるので、定期的にチェックして実行する.

1. windows/provision.batをコマンドラインから実行してアップデート
2. 以下の項目は手動アップデート/手動マージ

    <ul>
      <li>linux/ansible/roles/link/vscode/tasks/main.yml</li>
      <li>linux/ansible/wsl-ubuntu.yml</li>
      <li>linux/upgrade.sh</li>
    </ul>
    <br>
    <ul>
      <li>mnt/common/settings.json</li>
      <li>mnt\common\VSCode\User\settings.json(運用上不要)</li>
      <li>mnt\linux\ubuntu\.bashrc</li>
      <li>mnt/linux/ubuntu/.bash_logout</li>
      <li>mnt/linux/ubuntu/.vimrc</li>
      <li>mnt\windows\pipes-rs</li>
      <li>mnt\windows\power-shell</li>
      <li>mnt\windows\terminal</li>
      <li>mnt\windows\winget</li>
      <li>mnt\windows\wsl</li>
      <!--<li></li>-->
    </ul>
    <br>
    <ul>
      <li>windows\PSGallery</li>
      <li>windows\cargo</li>
      <li>windows\volta-npm</li>
      <li>windows\scoop</li>
      <li>windows\winget</li>
      <li>windows\ubuntu\config.xlaunch</li>
      <li>windows\ubuntu\Ubuntu_provision.ps1</li>
      <li>windows\install.ps1</li>
      <li>windows\provision.bat</li>
      <li>windows\Pull_SubModule.bat</li>
      <li>windows\xlaunch.exe.lnk</li>
    </ul>
3. 各install.ps1を実行してパッケージアップデート
4. 再度windows/provision.batを実行

# WSL2-Ubuntu20.04の手順

本家Tadashi Aikawa氏の資料を要参照<br>

1. <a href="https://blog.mamansoft.net/2020/07/02/efficient-wsl2-with-ubuntu/">WSL2でつくる快適なUbuntu環境</a>の"Windows起動時に自動起動させる"までを実行<br>
2. <a href="https://docs.microsoft.com/en-us/windows/wsl/wsl-config">WSL commands and launch configurations</a>等を参考に、wsl.confを設定<br>
   <a href="https://qiita.com/ys-0-sy/items/3cf7a29c1489bf5564f8">WSLでwindowsディレクトリがマウントされないのを対処した「備忘録」</a><br>
3. wsl側で<code>sudo apt update -y && sudo apt upgrade -y</code><br>
4. wsl側で<code>sudo apt-get update -y && sudo apt-get upgrade -y</code><br>
5. wsl側で<code>sudo apt install -y git-all</code><br>
6. <code>git clone git@github.com:kuni3933/WindowsTerminalSettings.git --recursive</code><br>
7. <a href="https://docs.github.com/ja/github/getting-started-with-github/getting-started-with-git/managing-remote-repositories">モートリポジトリを管理する</a>リポジトリのリモートURL(ssh)への変更を実行<br>
8. <a href="https://blog.mamansoft.net/2020/07/02/efficient-wsl2-with-ubuntu/">WSL2でつくる快適なUbuntu環境</a>の"Windows起動時に自動起動させる"以降を全て実行<br>
9. <a href="https://docs.microsoft.com/ja-jp/windows/wsl/tutorials/wsl-git">概要で Git を使用Linux 用 Windows サブシステム</a>を参考に、wsl側の.gitconfigを修正<br>
10. <a href="https://blog.mamansoft.net/2020/07/26/efficient-wsl2-with-ubuntu2/">WSL2でつくる快適なUbuntu環境Ⅱ</a>を全て実行<br>
11. <a href="https://github.com/tadashi-aikawa/owl-playbook">本家-tadashi-aikawa/owl-playbook</a>を参考に、wsl側のWindowsTerminalSettings/linux/ansibleで<code>make wsl</code>を実行<br>
12. WindowserminalSettings/linux/upgrade.shを実行<br>
13. pyenv initの設定<br>
14. vimを起動して、<code>:PlugInstall</code>と入力して実行<br>
15. vimを実行して、<code>:BundleInstall</code>と入力して実行<br>
16. ".bashrc"をリポジトリの.bashrcに変更<br>
    必要な部分はマージしつつ起動直後の内容等は削除して&HOMEの.bashrcには<br>
    <code>source ~/.bashrc.org↲</code><br>
    <code>[ -f ~/.fzf.bash ] && source ~/.fzf.bash</code><br>
    <code>export VOLTA_HOME="$HOME/.volta"</code><br>
    <code>export PATH="$VOLTA_HOME/bin:$PATH"</code>のみが記述されている状態にする<br>
17. <a href="https://docs.github.com/ja/github/authenticating-to-github/managing-commit-signature-verification">コミット署名の検証を管理する</a>を参考にgpgの設定<br>
      <a href="https://qiita.com/suzutan/items/cbd6fc56c0a50100e7c0">GnuPGことはじめ - ひととおりさわってみる</a>を参考に、最新のed25519で作成する事<br>
18. <a href="https://docs.github.com/ja/github/authenticating-to-github/connecting-to-github-with-ssh">GitHub に SSH で接続する</a>を参考にsshの設定<br>
19. gpg/sshの情報を.gitconfigに設定<br>

## 以下参考

<ul>
  <li><a href="https://blog.mamansoft.net/2020/05/31/windows-terminal-and-power-shell-makes-beautiful">Windows TerminalとPowerShellでクールなターミナル環境をつくってみた</a></li>
  <li><a href="https://github.com/tadashi-aikawa/owl-playbook">tadashi-aikawa/owl-playbook: Playbook both Linux and Windows for me</a></li>
  <li><a href="https://mikazuki.hatenablog.jp/entry/2020/08/01/173459">Windows の Terminal 環境を整えたい - みかづきメモ</a></li>
  <li><a href="https://secon.dev/entry/2020/08/17/070735/">MacOS ユーザが WSL では無い Windows のコンソール環境を整える - A Day in the Life</a></li>
  <li><a href="https://qiita.com/momomo_rimoto/items/30a95e457724746521c2#--%E3%82%B5%E3%83%96%E3%83%A2%E3%82%B8%E3%83%A5%E3%83%BC%E3%83%AB%E3%82%92%E6%9C%80%E6%96%B0%E3%81%AE%E3%83%96%E3%83%A9%E3%83%B3%E3%83%81%E3%81%AB%E3%81%99%E3%82%8B%E5%85%A8%E3%81%A6git-pull%E3%81%99%E3%82%8B">[git] 複数のリモートリポジトリを扱う&amp;サブモジュール&amp;複数のリモートリポジトリのサブモジュール - Qiita</a></li>
  <li><a href="https://qiita.com/kentarosasaki/items/3e670567c0512b9d411e">git clone の際に submodule の clone を忘れたときの対処法 - Qiita</a></li>
</ul>
