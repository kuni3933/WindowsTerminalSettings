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

1. <code>winget install -e --id Git.Git</code>

2. <code>git clone https://github.com/kuni3933/WindowsTerminalSettings --recursive</code>

## 3.Windows Terminal Preview(WTP)・PowerShellCore(pwsh)・VSCode・VSCode-Insidersのインストール

※インストール済みの場合は、アンインストールしておくか各ステップをスキップする.※

1. <code>Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force</code><br>
2. <code>WindowsTerminalSettings/windows/winget/install.ps1</code><br>
  を実行して、Git・WTP・pwsh・VSCode・VSCode-Insidersの5つをインストール

  ※すでにインストール済みだった場合は、アンインストールしてから実行する.

  (そうでないと同じものが２つインストールされて面倒な状況になってしまうので要注意)

※以下のコマンドを実行して、セキュリティポリシーがCurrentUserのみRemoteSignedとなっていることを確認する.

  <code>Get-ExecutionPolicy -l</code>

  それ以外の場合は、1番で使用したコマンドを修正入力して実行

## 4.パス設定

1. このリポジトリが配置されているパスを、ユーザー環境変数:WindowsTerminalSettings として登録

    以下、「C:/Users/ユーザー名/WindowsTerminalSettings(このリポジトリ)」という配置状況での例

    <code>ユーザー環境変数名:WindowsTerminalSettings</code><br>
    <code>ユーザー環境変数値:C:/Users/ユーザー名/WindowsTerminalSettings</code><br>

2. 今度はGitがインストールされたフォルダを、システム環境変数:GIT_INSTALL_ROOT として登録

    まずは以下のコマンドを実行してgit.exeの位置を確認

    <code>cmd /c where git</code><br>

   出力された位置の2階層上に位置するGitフォルダを環境変数GIT_INSTALL_ROOTとして登録する.

    <code>C:\Program Files\Git\cmd\git.exe</code>と出力されたら以下の設定<br>
    <code>システム環境変数名:GIT_INSTALL_ROOT</code><br>
    <code>システム環境変数値:C:\Program Files\Git</code><br>

## 5.フォントのインストール

1. 以下から好きなフォントをダウンロードしてWindows Compatible版だけは必ずインストールする.

    * <a href="https://www.nerdfonts.com/#home">Nerd Fonts - Iconic font aggregator, glyphs/icons collection, &amp; fonts patcher</a>

    おすすめは「Source Code Pro」で、以下から直接ダウンロード可能

    * <a href="https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/SourceCodePro.zip">Nerd Fonts - Iconic font aggregator, glyphs/icons collection, &amp; fonts patcher - Sauce Code Pro Nerd Font</a>

  7.依存パッケージのscoop/install.ps1を実行した後、以下にアクセスすれば簡単
  <li>%USERPROFILE%/scoop/apps/SourceCodePro-NF-Mono</li>
  <li>%USERPROFILE%/scoop/apps/SourceCodePro-NF</li>

## 6.pwshのモジュールインストール・scoopの有効化(有効化済みの場合はスキップ)

pwsh上で以下のコマンドを管理者権限で実行

1. <code>Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force</code>
2. <code>Install-Module posh-git -Scope CurrentUser -Force</code>
3. <code>Install-Module oh-my-posh -Scope CurrentUser -Force</code>
4. <code>Install-Module -Name PSReadLine -Scope CurrentUser -Force</code>
5. <code>iwr -useb get.scoop.sh | iex</code>

※以下のコマンドを実行して、セキュリティポリシーがCurrentUserのみRemoteSignedとなっていることを確認する.

なっていなかった場合は、1番で使用したコマンドを修正入力して実行

<code>Get-ExecutionPolicy -l</code>

## 7.依存packageインストール

`windows`ディレクトリ配下の`install.ps1`をコマンドラインから管理者権限で実行してインストール.
※既にインストール済みの物がないかinstall.ps1を要確認※
※インストール済みのものがあったら、install.ps1をエディターで開いて調節及びvscodeとgitはアンインストールしてから実行する※

| ディレクトリ | 概要                                                            |
| ------------ | --------------------------------------------------------------- |
| 1.winget     | wingetでインストールするもの                                    |
| 2.scoop      | Scoopでインストールするもの                                     |
| 3.volta/npm  | volta/npmでインストールするもの                                 |
| 4.go         | goでインストールするもの                                        |
| 5.cargo      | rustでインストールするもの                                      |
| 6.ubuntu     | WSL2-Ubuntu-20.04 LTSでインストールするもの(wsl2準備段階で使用) |
初インストールの場合は、
<ul>
<li>Keypirinha</li>
<li>VScode</li>
<li>pwsh</li>
</ul>
を一回起動してまた閉じておく.

また、cargo/install.ps1の実行前に、
<li><a href="https://yuqlid.sakura.ne.jp/dokuwiki/msys2">MSYS2 [yuqlid wiki]</a></li>
<li><a href="https://qiita.com/ousttrue/items/ee617544ab737fc34c1d">WindowsでRust環境を作ってGtk3でOpenGLする - Qiita</a></li>
<li><a href="https://gist.github.com/Hamayama/eb4b4824ada3ac71beee0c9bb5fa546d">MSYS2/MinGW-w64 (64bit/32bit) インストール手順 メモ</a></li>
を参考にmsys2/mingwのUPDATEをしておく.

## 8.windows/provision.batをコマンドラインから管理者権限で実行

※install.ps1にしたがわないでgitをインストールする場合は、windows/provision.batのgitconfigコピー処理を消してから実行する※

## 9.定期アップデート

インストール後に更新ファイルがあった場合は以下の作業をする必要があるので、定期的にチェックして実行する.

1. windows/provision.batをコマンドラインから実行してアップデート
2. 以下の項目は手動アップデート/手動マージ

    <ul>
      <li>linux/ansible/roles/link/vscode/tasks/main.yml</li>
      <li>linux/ansible/wsl-ubuntu.yml</li>
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
      <li>windows\cargo</li>
      <li>windows\volta-npm</li>
      <li>windows\scoop</li>
      <li>windows\winget</li>
      <li>windows\provision.bat</li>
      <li>windows\Pull_SubModule.bat</li>
      <li>windows\xlaunch.exe.lnk</li>
    </ul>
3. 各install.ps1を実行してパッケージアップデート
4. 再度windows/provision.batを実行

# WSL2-Ubuntu20.04の手順

本家Tadashi Aikawa氏の資料を要参照<br>

1. <a href="https://blog.mamansoft.net/2020/07/02/efficient-wsl2-with-ubuntu/">WSL2でつくる快適なUbuntu環境</a>の"Windows起動時に自動起動させる"までを実行<br>
2. wsl側で<code>sudo apt update && sudo apt upgrade</code><br>
3. wsl側で<code>sudo apt-get update && sudo apt-get upgrade</code><br>
4. wsl側で<code>sudo apt-get install git-all</code><br>
5. <code>git clone https://github.com/kuni3933/WindowsTerminalSettings --recursive</code><br>
6. WindowserminalSettings/linux/upgrade.shを実行<br>
7. <a href="https://blog.mamansoft.net/2020/07/02/efficient-wsl2-with-ubuntu/">WSL2でつくる快適なUbuntu環境</a>の"Windows起動時に自動起動させる"以降を全て実行<br>
8. <a href="https://docs.microsoft.com/ja-jp/windows/wsl/tutorials/wsl-git">概要で Git を使用Linux 用 Windows サブシステム</a>を参考に、wsl側の.gitconfigを修正<br>
9. <a href="https://blog.mamansoft.net/2020/07/26/efficient-wsl2-with-ubuntu2/">WSL2でつくる快適なUbuntu環境Ⅱ</a>を全て実行<br>
10. <a href="https://github.com/tadashi-aikawa/owl-playbook">本家-tadashi-aikawa/owl-playbook</a>を参考に、wsl側のWindowsTerminalSettings/linux/ansibleで<code>make wsl</code>を実行<br>
11. pyenv initの設定<br>
12. vimを起動して、<code>:PlugInstall</code>と入力して実行<br>
13. ".bashrc"をリポジトリの.bashrcに変更(必要な部分はマージしつつ、起動直後の内容等は削除)<br>
14. <a href="https://docs.github.com/ja/github/authenticating-to-github/managing-commit-signature-verification">コミット署名の検証を管理する</a>を参考にgpgの設定<br>
      <a href="https://qiita.com/suzutan/items/cbd6fc56c0a50100e7c0">GnuPGことはじめ - ひととおりさわってみる</a>を参考に、最新のed25519で作成する事<br>
15. <a href="https://docs.github.com/ja/github/authenticating-to-github/connecting-to-github-with-ssh">GitHub に SSH で接続する</a>を参考にsshの設定<br>
16. gpg/sshの情報を.gitconfigに設定<br>

## 以下参考

<ul>
  <li><a href="https://blog.mamansoft.net/2020/05/31/windows-terminal-and-power-shell-makes-beautiful">Windows TerminalとPowerShellでクールなターミナル環境をつくってみた</a></li>
  <li><a href="https://github.com/tadashi-aikawa/owl-playbook">tadashi-aikawa/owl-playbook: Playbook both Linux and Windows for me</a></li>
  <li><a href="https://mikazuki.hatenablog.jp/entry/2020/08/01/173459">Windows の Terminal 環境を整えたい - みかづきメモ</a></li>
  <li><a href="https://secon.dev/entry/2020/08/17/070735/">MacOS ユーザが WSL では無い Windows のコンソール環境を整える - A Day in the Life</a></li>
  <li><a href="https://qiita.com/momomo_rimoto/items/30a95e457724746521c2#--%E3%82%B5%E3%83%96%E3%83%A2%E3%82%B8%E3%83%A5%E3%83%BC%E3%83%AB%E3%82%92%E6%9C%80%E6%96%B0%E3%81%AE%E3%83%96%E3%83%A9%E3%83%B3%E3%83%81%E3%81%AB%E3%81%99%E3%82%8B%E5%85%A8%E3%81%A6git-pull%E3%81%99%E3%82%8B">[git] 複数のリモートリポジトリを扱う&amp;サブモジュール&amp;複数のリモートリポジトリのサブモジュール - Qiita</a></li>
  <li><a href="https://qiita.com/kentarosasaki/items/3e670567c0512b9d411e">git clone の際に submodule の clone を忘れたときの対処法 - Qiita</a></li>
</ul>
