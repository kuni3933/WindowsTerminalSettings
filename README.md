# WindowsTerminalSettings

## 1.以下からMicrosoft.DesktopAppInstaller(winget)をインストール

<ul>
  <li><a href="https://github.com/microsoft/winget-cli/releases">Releases · microsoft/winget-cli</a></li>
</ul>
適切なバージョンをインストール

## 2.Windows Terminal Preview(WTP)・PowerShellCore(pwsh)のインストール

<ul>
  <li>方法1.MicrosoftStoreアプリからインストール(WTPのみ対応)</li>
  <li>方法2.githubのreleaseページを検索してそこからインストール</li>
  <li>方法3(推奨)Wingetコマンド(以下のコマンド)でインストール</li>
    <code>winget install -e --id Microsoft.WindowsTerminalPreview</code><br>
    <code>winget install -e --id Microsoft.PowerShell</code><br>
  ※すでにインストール済みだった場合は、アンインストールしてから実行する事。<br>
  (そうでないと同じものが２つインストールされて面倒な状況になってしまうので要注意)<br>
</ul>

## 3.フォントのインストール

1. 以下から「Source Code Pro」をダウンロードしてWindows Compatible版だけは必ずインストールする。
    <a href="https://www.nerdfonts.com/#home">Nerd Fonts - Iconic font aggregator, glyphs/icons collection, &amp; fonts patcher</a>

## 4.scoopの有効化とモジュールインストール

pwsh上で以下のコマンドを管理者権限で実行

1. <code>Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force</code>
2. <code>iwr -useb get.scoop.sh | iex</code>
3. <code>Install-Module posh-git -Scope CurrentUser -Force</code>
4. <code>Install-Module oh-my-posh -Scope CurrentUser -Force</code>
5. <code>Install-Module -Name PSReadLine -Scope CurrentUser -Force -SkipPublisherCheck</code>

   以下はinstall.ps1でzモジュールをインストールせずに、
   PowershellGallery側のモジュールをインストールして代用する際に実行。
6. <code>Install-Module -Name z</code>

※以下のコマンドを実行して、セキュリティポリシーが
CurrentUserのみRemoteSignedとなっていることを確認する事。

<code>Get-ExecutionPolicy -l</code>

それ以外の場合は、1番で使用したコマンドを修正入力して実行

## 5.依存packageインストール

`windows`ディレクトリ配下の`install.ps1`をコマンドラインから管理者権限で実行してインストール。
※既にインストール済みの物がないかinstall.ps1を要確認※
※インストール済みのものがあったら、install.ps1をエディターで開いて調節及びvscodeとgitはアンインストールしてから実行する事※

| ディレクトリ | 概要                        |
| ------------ | --------------------------- |
| scoop        | Scoopでインストールするもの |
| npm          | npmでインストールするもの   |
| go           | goでインストールするもの    |

初インストールの場合は、
<ul>
<li>Keypirinha</li>
<li>VScode</li>
<li>pwsh</li>
</ul>
を一回起動してまた閉じておく。

## 6.windows/provision.batをコマンドラインから管理者権限で実行

※install.ps1にしたがわないでgitをインストールする場合は、windows/provision.batのgitconfigコピー処理を消してから実行する事※

## 7.定期アップデート

インストール後に更新ファイルがあった場合は以下の作業をする必要があるので、定期的にチェックして実行する事。

1. windows/provision.batをコマンドラインから実行してアップデート
2. 以下の項目は手動アップデート/手動マージ
    <ul>
      <li>mnt/common/settings.json</li>
      <li>mnt/windows/power-shell/*</li>
      <li>mnt/windows/terminal/*</li>
      <li>mnt/windows/.bashrc</li>
      <li>windows/scoop/install.ps1</li>
      <li>windows/provision.bat</li>
      <!--<li></li>-->
    </ul>
3. install.ps1を実行してパッケージアップデート
4. 再度windows/provision.batを実行

## 以下参考

<ul>
<li><a href="https://blog.mamansoft.net/2020/05/31/windows-terminal-and-power-shell-makes-beautiful">Windows TerminalとPowerShellでクールなターミナル環境をつくってみた</a></li>
  <li><a href="https://github.com/tadashi-aikawa/owl-playbook">tadashi-aikawa/owl-playbook: Playbook both Linux and Windows for me</a></li>
  <li><a href="https://mikazuki.hatenablog.jp/entry/2020/08/01/173459">Windows の Terminal 環境を整えたい - みかづきメモ</a></li>
  <li><a href="https://secon.dev/entry/2020/08/17/070735/">MacOS ユーザが WSL では無い Windows のコンソール環境を整える - A Day in the Life</a></li>
</ul>


## メモ

<ul>
   <li>install.batでインストール時にエラーを返すパッケージが３~程確認されている</li>
</ul>
