# WindowsTerminalSettings
## 1.Windows Terminal Preview・PowerShell Core(pwsh)のインストール
1. 以下からpwshをインストール
  <a href="https://github.com/PowerShell/PowerShell/releases">Releases · PowerShell/PowerShell</a>
## 2.フォントのインストール
1. 以下から「Source Code Pro」をダウンロードしてWindows Compatible版だけは必ずインストールする。
    <a href="https://www.nerdfonts.com/#home">Nerd Fonts - Iconic font aggregator, glyphs/icons collection, &amp; fonts patcher</a>
## 2.scoopの有効化とモジュールインストール
pwsh上で以下のコマンドを実行
1. <code>Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force</code>
2. <code>iwr -useb get.scoop.sh | iex</code>
3. <code>Install-Module posh-git -Scope CurrentUser -Force</code>
4. <code>Install-Module oh-my-posh -Scope CurrentUser -Force</code>
5. <code>Install-Module -Name PSReadLine -Scope CurrentUser -Force -SkipPublisherCheck</code>

   以下はinstall.ps1でzモジュールをインストールしない場合のために、
   PowershellGallery側のモジュールをインストールする際に実行。
6. <code>Install-Module -Name z</code>

もしScoopでgitをインストールする場合は、付属のgitconfigと以下のgitconfigを入れ替える。
<code>C:/ProgramData/scoop/apps/git/current/etc/gitconfig</code>
## 3.シンボリックリンク作成
1. mklinkコマンドでWindowsTerminalのsetting.jsonを指すシンボリックリンクを作成し、適切な位置に配置(以下参考)
   <a href="https://qiita.com/ma2shita/items/a6256ef3d81329f52ec7">Windows Terminal の設定(settings.json)を複数の PC で共有する方法 (OneDrive の場合) - Qiita</a>
2. 同じく.PS1ファイルのシンボリックリンクを作成し配置
   適切な位置(%USERPROFILE%\Documents\PowerShell)の下に配置する。
3. Provisioフォルダ内のinstall.ps1を各自実行して、パッケージのインストールを行う。
## 参考
<ul>
<li><a href="https://blog.mamansoft.net/2020/05/31/windows-terminal-and-power-shell-makes-beautiful">Windows TerminalとPowerShellでクールなターミナル環境をつくってみた</a></li>
  <li><a href="https://github.com/tadashi-aikawa/owl-playbook">tadashi-aikawa/owl-playbook: Playbook both Linux and Windows for me</a></li>
  <li><a href="https://mikazuki.hatenablog.jp/entry/2020/08/01/173459">Windows の Terminal 環境を整えたい - みかづきメモ</a></li>
  <li><a href="https://secon.dev/entry/2020/08/17/070735/">MacOS ユーザが WSL では無い Windows のコンソール環境を整える - A Day in the Life</a></li>
</ul>
## メモ
<ul>
   <li>install.ps1で、lessがコメント状態になっていることでエラーが発生している<li>
</ul>
