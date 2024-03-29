# WindowsTerminalSettings

<li><a href="https://github.com/tadashi-aikawa/owl-playbook">tadashi-aikawa/owl-playbook: Playbook both Linux and Windows for me</a></li>
<li><a href="https://github.com/sheepla/dotfiles">sheepla/dotfiles</a></li>
をベースに個人的に改造したもの

## 1.以下からMicrosoft.DesktopAppInstaller(winget)・フォントをインストール

<ul>
  <li><a href="https://github.com/microsoft/winget-cli/releases">Releases · microsoft/winget-cli</a></li>
  <li><a href="https://github.com/adobe-fonts/source-han-code-jp/releases">Releases · adobe-fonts/source-han-code-jp</a></li>
  <li><a href="https://github.com/yuru7/PlemolJP/releases">Releases · yuru7/PlemolJP</a></li>
</ul>

## 2.wingetでGit,pwsh,Windows Terminal Preview(WTP)のインストール・本リポジトリの配置

<code>Windows Powershell (admin New Session)</code><br>
```Powershell
winget install -e --id Git.Git --source winget
winget install -e --id Microsoft.PowerShell --source winget
winget install -e --id Microsoft.WindowsTerminal.Preview --source winget
```
<code>pwsh (admin New Session) </code><br>
```Powershell
cd $env:USERPROFILE
git clone https://github.com/kuni3933/WindowsTerminalSettings --recursive
```

## 3.パス設定

Gitがインストールされたフォルダを、システム環境変数:GIT_INSTALL_ROOT として登録

1. まずは以下のコマンドを実行してgit.exeの位置を確認.<br>
  <code>pwsh (admin New Session) </code><br>
    ```Powershell
    cmd /c where git
    ```

2. 出力された位置の2階層上に位置するGitフォルダを環境変数GIT_INSTALL_ROOTとして登録する.<br>
  <code>C:\Program Files\Git\cmd\git.exe</code>と出力されたら以下の設定<br>
  <code>システム環境変数名:GIT_INSTALL_ROOT</code><br>
  <code>システム環境変数値:C:\Program Files\Git</code><br>

## 4.依存packageインストール

<code>pwsh (admin New Session) </code><br>
```Powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
cd $env:USERPROFILE/WindowsTerminalSettings
windows/install.ps1
```

| ディレクトリ | 概要                                                            |
| ------------ | ---------------------------------------------------------------|
| 1.PSGallery  | PSGalleryでインストールするもの                                 |
| 2.winget     | wingetでインストールするもの                                    |
| 3.scoop      | scoopでインストールするもの                                     |
| 4.Chocolatey | chocolateyでインストールするもの                                |
| 5.volta/npm  | volta/npmでインストールするもの                                 |
| 6.go         | goでインストールするもの                                        |
| 7.cargo      | rust/cargoでインストールするもの                                |

初インストールの場合は、install.ps1を実行後
<ul>
<li>Keypirinha</li>
<li>VScode</li>
<li>pwsh</li>
</ul>
を一回起動して閉じたあとに再度windows/install.ps1を実行.

## 5.windows/provision.batをコマンドラインから管理者権限で実行

<code>pwsh (admin New Session) </code><br>
```Powershell
cd $env:USERPROFILE/WindowsTerminalSettings
sudo windows/provision.bat
```

# WSL2の手順

本家Tadashi Aikawa氏の資料を要参照<br>
<ul>
  <li><a href="https://blog.mamansoft.net/2020/07/02/efficient-wsl2-with-ubuntu/">WSL2でつくる快適なUbuntu環境</a></li>
  <li><a href="https://blog.mamansoft.net/2020/07/26/efficient-wsl2-with-ubuntu2/">WSL2でつくる快適なUbuntu環境Ⅱ</a></li>
</ul>

<a href="https://blog.mamansoft.net/2020/07/02/efficient-wsl2-with-ubuntu/">WSL2でつくる快適なUbuntu環境</a>を実行していく<br>

1. 以下のコマンドでWSLを有効にする<br>
  <code>pwsh (admin New Session) </code><br>
    ```Powershell
    sudo dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
    ```

2. VMを有効にする<br>
  <code>pwsh (admin New Session) </code><br>
    ```Powershell
    sudo dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
    ```

3. <a href="https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi">x64 マシン用 WSL2 Linux カーネル更新プログラム パッケージ</a>から更新プログラムをダウンロードして実行<br>
  参考 - <a href="https://docs.microsoft.com/ja-jp/windows/wsl/install-win10#step-4---download-the-linux-kernel-update-package">手順 4 - Linux カーネル更新プログラム パッケージをダウンロードする</a><br>

4. <code>pwsh (admin New Session) </code>
    ```Powershell
    sudo wsl --set-default-version 2
    ```


## Archの手順


1. Setupo DistroD & Install Any Distribution<br>
<a href="https://github.com/nullpo-head/wsl-distrod">nullpo-head/wsl-distrod</a>

2. Setup root password<br>
  <code>pwsh (admin New Session) </code><br>
    ```Powershell
    sudo su -
    passwd
    ```

3. User Add wheel group<br>
  <code>pwsh</code><br>
    ```Powershell
    gpasswd -a {username} wheel
    ```
    ※{username} = UserName※<br>

4. 鍵の初期化<br>
  <code>pwsh</code><br>
    ```Powershell
    pacman-key --init
    ```

5. 鍵の更新<br>
  <code>pwsh</code><br>
    ```Powershell
    pacman-key --populate archlinux
    pacman -Syy archlinux-keyring
    ```

6. パッケージの更新・必要なPackageのインストール<br>
  <code>pwsh</code><br>
    ```Powershell
    sudo pacman -Syyu --needed aria2 autoconf automake  base base-devel curl git gnupg make neovim ntp openssh sudo vi vim wget
    ```

7. /etc/sudoersを編集してwheel ユーザグループに sudo 権限を付与する。<br>
  <code>pwsh</code><br>
    ```Powershell
    nano /etc/sudoers
    ```
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
  <code>pwsh</code><br>
    ```Powershell
    vim /etc/pacman.d/mirrorlist
    ```
    <a href="https://wiki.archlinux.jp/index.php/%E3%83%89%E3%83%A1%E3%82%A4%E3%83%B3%E5%90%8D%E5%89%8D%E8%A7%A3%E6%B1%BA">必要ならこちらも設定</a><br>

10. Setup wsl.conf with powershell<br>
  <code>pwsh (admin New Session) </code><br>
    ```Powershell
    cd $env:USERPROFILE/WindowsTerminalSettings/windows/Distrod
    .\Distrod_provision.ps1
    ```

11. setup<br>
  <code>WindowsTerminaからArch実行</code><br>
  <code>bash (Distrod)</code>
    ```bash
    git clone git@github.com:kuni3933/WindowsTerminalSettings.git --recursive
    cd ~/WindowsTerminalSettings/mnt/linux/Arch
    ./setup.sh
    ```

12. setup .bashrc<br>
  必要な部分はマージしつつ起動直後の内容等は削除して$HOMEの.bashrcには<br>
  <code>. ~/.bashrc.org</code><br>
  <code>export PATH=$PATH:'/mnt/c/Users/{Windows_username}/AppData/Local/Programs/Microsoft VS Code/bin'</code><br>
  のみが記述されている状態にする<br>
  ({Windows_username} = Windows UserName)<br>


## 以下参考

<ul>
  <li><a href="https://blog.mamansoft.net/2020/05/31/windows-terminal-and-power-shell-makes-beautiful">Windows TerminalとPowerShellでクールなターミナル環境をつくってみた</a></li>
  <li><a href="https://wiki.archlinux.jp/index.php/WSL_%E3%81%AB%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB">WSL にインストール - ArchWiki</a></li>
  <li><a href="https://mikazuki.hatenablog.jp/entry/2020/08/01/173459">Windows の Terminal 環境を整えたい - みかづきメモ</a></li>
  <li><a href="https://secon.dev/entry/2020/08/17/070735/">MacOS ユーザが WSL では無い Windows のコンソール環境を整える - A Day in the Life</a></li>
  <li><a href="https://qiita.com/momomo_rimoto/items/30a95e457724746521c2#--%E3%82%B5%E3%83%96%E3%83%A2%E3%82%B8%E3%83%A5%E3%83%BC%E3%83%AB%E3%82%92%E6%9C%80%E6%96%B0%E3%81%AE%E3%83%96%E3%83%A9%E3%83%B3%E3%83%81%E3%81%AB%E3%81%99%E3%82%8B%E5%85%A8%E3%81%A6git-pull%E3%81%99%E3%82%8B">[git] 複数のリモートリポジトリを扱う&amp;サブモジュール&amp;複数のリモートリポジトリのサブモジュール - Qiita</a></li>
  <li><a href="https://qiita.com/kentarosasaki/items/3e670567c0512b9d411e">git clone の際に submodule の clone を忘れたときの対処法 - Qiita</a></li>
</ul>
