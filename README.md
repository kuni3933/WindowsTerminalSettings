# WindowsTerminalSettings

<li><a href="https://github.com/tadashi-aikawa/owl-playbook">tadashi-aikawa/owl-playbook: Playbook both Linux and Windows for me</a></li>
<li><a href="https://github.com/sheepla/dotfiles">sheepla/dotfiles</a></li>
をベースに個人的に改造したもの

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
3. <code>cd $env:USERPROFILE/WindowsTerminalSettings</code><br>
4. <code>windows/winget/install.ps1</code><br>
  を実行して、Git・WTP・pwsh・VSCode・VSCode-Insidersの5つをインストール

## 4.パス設定

Gitがインストールされたフォルダを、システム環境変数:GIT_INSTALL_ROOT として登録

1. まずは以下のコマンドを実行してgit.exeの位置を確認.<br>
    <code>cmd /c where git</code><br>
2. 出力された位置の2階層上に位置するGitフォルダを環境変数GIT_INSTALL_ROOTとして登録する.<br>
    <code>C:\Program Files\Git\cmd\git.exe</code>と出力されたら以下の設定<br>
    <code>システム環境変数名:GIT_INSTALL_ROOT</code><br>
    <code>システム環境変数値:C:\Program Files\Git</code><br>

## 5.依存packageインストール

1. <code>pwshを管理者権限で開く</code><br>
2. <code>cd $env:USERPROFILE/WindowsTerminalSettings</code><br>
3. <code>windows/install.ps1</code><br>

| ディレクトリ | 概要                                                            |
| ------------ | --------------------------------------------------------------- |
| 1.PSGallery  | PSGalleryでインストールするもの                                 |
| 2.winget     | wingetでインストールするもの                                    |
| 3.scoop      | Scoopでインストールするもの                                     |
| 4.volta/npm  | volta/npmでインストールするもの                                 |
| 5.go         | goでインストールするもの                                        |
| 6.cargo      | rustでインストールするもの                                      |

初インストールの場合は、install.ps1を実行後
<ul>
<li>Keypirinha</li>
<li>VScode</li>
<li>pwsh</li>
</ul>
を一回起動して閉じたあとに再度windows/install.ps1を実行.

フォントもインストール
<ul>
    <li><a href="https://github.com/adobe-fonts/source-han-code-jp/releases">Releases · adobe-fonts/source-han-code-jp</a><li>
    <li><a href="https://github.com/yuru7/PlemolJP/releases">Releases · yuru7/PlemolJP</a><li>
<ul>


## 6.windows/provision.batをコマンドラインから管理者権限で実行

1. <code>pwshを管理者権限で開く</code><br>
2. <code>cd $env:USERPROFILE/WindowsTerminalSettings</code><br>
3. <code>sudo windows/provision.bat</code><br>


# WSL2の手順


本家Tadashi Aikawa氏の資料を要参照<br>
<ul>
  <li><a href="https://blog.mamansoft.net/2020/07/02/efficient-wsl2-with-ubuntu/">WSL2でつくる快適なUbuntu環境</a></li>
  <li><a href="https://blog.mamansoft.net/2020/07/26/efficient-wsl2-with-ubuntu2/">WSL2でつくる快適なUbuntu環境Ⅱ</a></li>
</ul>

<a href="https://blog.mamansoft.net/2020/07/02/efficient-wsl2-with-ubuntu/">WSL2でつくる快適なUbuntu環境</a>を実行していく<br>

1. pwshを開く
2. 以下のコマンドでWSLを有効にする<br>
    <code>sudo dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart</code><br>
3. VMを有効にする<br>
    <code>sudo dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart</code><br>
4. <a href="https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi">x64 マシン用 WSL2 Linux カーネル更新プログラム パッケージ</a>から更新プログラムをダウンロードして実行<br>
  参考 - <a href="https://docs.microsoft.com/ja-jp/windows/wsl/install-win10#step-4---download-the-linux-kernel-update-package">手順 4 - Linux カーネル更新プログラム パッケージをダウンロードする</a><br>
5. PC再起動した後pwshを開く
6. <code>sudo wsl --set-default-version 2</code>

## Archの手順


1. Setupo DistroD & Install Any Distribution<br>
<a href="https://github.com/nullpo-head/wsl-distrod">nullpo-head/wsl-distrod</a>

2. Setup root password<br>
<code>sudo su -</code><br>
<code>passwd</code>

3. User Add wheel group<br>
<code>gpasswd -a {username} wheel</code><br>
({username}=ユーザー名)<br>

4. 鍵の初期化<br>
<code>pacman-key --init</code><br>

5. 鍵の更新<br>
<code>pacman-key --populate archlinux</code><br>
<code>pacman -Syy archlinux-keyring</code><br>

6. パッケージの更新・必要なPackageのインストール<br>
<code>sudo pacman -Syyu --needed aria2 autoconf automake  base base-devel curl git gnupg make neovim ntp openssh sudo vi vim wget</code><br>

7. /etc/sudoersを編集してwheel ユーザグループに sudo 権限を付与する。<br>
<code>nano /etc/sudoers</code><br>
キーバインド:M = meta key = Alt<br>
以下の行を探してアンコメント<br>
<code>%wheel ALL=(ALL) ALL</code><br>

8. close nano<br>
以下のコマンドでnanoを閉じて保存終了<br>
<code>ctrl + x</code><br> 
<code>y</code><br>
<code>ENTER</code><br>
<code>exit</code><br>

9. mirrorlstの確認と設定<br>
<code>vim /etc/pacman.d/mirrorlist</code><br>
<a href="https://wiki.archlinux.jp/index.php/%E3%83%89%E3%83%A1%E3%82%A4%E3%83%B3%E5%90%8D%E5%89%8D%E8%A7%A3%E6%B1%BA">必要ならこちらも設定</a><br>

10. Setup wsl.conf with powershell<br>
<code>cd $env:USERPROFILE/WindowsTerminalSettings/windows/Distrod</code><br>
<code>.\Distrod_provision.ps1</code><br>

11. setup<br>
<code>WindowsTerminaからArch実行</code><br>
<code>git clone git@github.com:kuni3933/WindowsTerminalSettings.git --recursive</code><br>
<code>cd ~/WindowsTerminalSettings/mnt/linux/Arch</code><br>
<code>./setup.sh</code><br>

12. setup .bashrc<br>
必要な部分はマージしつつ起動直後の内容等は削除して$HOMEの.bashrcには<br>
<code>. ~/.bashrc.org</code><br>
<code>export PATH=$PATH:'/mnt/c/Users/{Windows_username}/AppData/Local/Programs/Microsoft VS Code/bin'</code><br>
のみが記述されている状態にする<br>
({Windows_username}=Windowsのユーザー名)<br>


## 以下参考

<ul>
  <li><a href="https://blog.mamansoft.net/2020/05/31/windows-terminal-and-power-shell-makes-beautiful">Windows TerminalとPowerShellでクールなターミナル環境をつくってみた</a></li>
  <li><a href="https://wiki.archlinux.jp/index.php/WSL_%E3%81%AB%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB">WSL にインストール - ArchWiki</a></li>
  <li><a href="https://mikazuki.hatenablog.jp/entry/2020/08/01/173459">Windows の Terminal 環境を整えたい - みかづきメモ</a></li>
  <li><a href="https://secon.dev/entry/2020/08/17/070735/">MacOS ユーザが WSL では無い Windows のコンソール環境を整える - A Day in the Life</a></li>
  <li><a href="https://qiita.com/momomo_rimoto/items/30a95e457724746521c2#--%E3%82%B5%E3%83%96%E3%83%A2%E3%82%B8%E3%83%A5%E3%83%BC%E3%83%AB%E3%82%92%E6%9C%80%E6%96%B0%E3%81%AE%E3%83%96%E3%83%A9%E3%83%B3%E3%83%81%E3%81%AB%E3%81%99%E3%82%8B%E5%85%A8%E3%81%A6git-pull%E3%81%99%E3%82%8B">[git] 複数のリモートリポジトリを扱う&amp;サブモジュール&amp;複数のリモートリポジトリのサブモジュール - Qiita</a></li>
  <li><a href="https://qiita.com/kentarosasaki/items/3e670567c0512b9d411e">git clone の際に submodule の clone を忘れたときの対処法 - Qiita</a></li>
</ul>
