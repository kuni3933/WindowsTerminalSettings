# WindowsTerminalSettings

## 1.scoopの有効化(有効化済みの場合はスキップ)

デフォルトのPowershellから以下のコマンドを管理者権限で実行

1. <code>Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force</code>
2. <code>iwr -useb get.scoop.sh | iex</code>

※以下のコマンドを実行して、セキュリティポリシーがCurrentUserのみRemoteSignedとなっていることを確認する事。

なっていなかった場合は、1番で使用したコマンドを修正入力して実行

<code>Get-ExecutionPolicy -l</code>

## 2.Gitの有効化・本リポジトリのインストール

デフォルトのPowershellから以下のコマンドを管理者権限で実行

1. <code>scoop install git -g</code>(インストール済みならスキップ)
2. <code>git clone https://github.com/kuni3933/WindowsTerminalSettings --recursive</code>

## 3.このリポジトリが配置されているパスをユーザー環境変数として登録

このリポジトリが配置されているパスを、ユーザー環境変数:WindowsTerminalSettingsとして登録

以下、「C:/Users/ユーザー名/WindowsTerminalSettings(このリポジトリ)」という配置状況での例

<code>ユーザー環境変数名:WindowsTerminalSettings</code><br>
<code>ユーザー環境変数値:C:/Users/ユーザー名/WindowsTerminalSettings</code>

## 4.以下からMicrosoft.DesktopAppInstaller(winget)をインストール

<ul>
  <li><a href="https://github.com/microsoft/winget-cli/releases">Releases · microsoft/winget-cli</a></li>
</ul>
適切なバージョンをインストール

## 5.Windows Terminal Preview(WTP)・PowerShellCore(pwsh)のインストール

<ul>
  <li>方法1.MicrosoftStoreアプリからインストール(WTPのみ対応)</li>
  <li>方法2.githubのreleaseページを検索してそこからインストール</li>
  <li>方法3(推奨)Wingetコマンド(以下のコマンド)でインストール</li>
    <code>winget install -e --id Microsoft.WindowsTerminalPreview</code><br>
    <code>winget install -e --id Microsoft.PowerShell</code><br>
  ※すでにインストール済みだった場合は、アンインストールしてから実行する事。<br>
  (そうでないと同じものが２つインストールされて面倒な状況になってしまうので要注意)<br>
</ul>

## 6.フォントのインストール

1. 以下から「Source Code Pro」をダウンロードしてWindows Compatible版だけは必ずインストールする。
    <a href="https://www.nerdfonts.com/#home">Nerd Fonts - Iconic font aggregator, glyphs/icons collection, &amp; fonts patcher</a>

## 7.pwshのモジュールインストール

pwsh上で以下のコマンドを管理者権限で実行

1. <code>Install-Module posh-git -Scope CurrentUser -Force</code>
2. <code>Install-Module oh-my-posh -Scope CurrentUser -Force</code>
3. <code>Install-Module -Name PSReadLine -Scope CurrentUser -Force</code>

※以下のコマンドを実行して、セキュリティポリシーがCurrentUserのみRemoteSignedとなっていることを確認する事。

<code>Get-ExecutionPolicy -l</code>

それ以外の場合は、1番で使用したコマンドを修正入力して実行

## 8.依存packageインストール

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

## 9.windows/provision.batをコマンドラインから管理者権限で実行

※install.ps1にしたがわないでgitをインストールする場合は、windows/provision.batのgitconfigコピー処理を消してから実行する事※

## 10.定期アップデート

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
  <li><a href="https://qiita.com/momomo_rimoto/items/30a95e457724746521c2#--%E3%82%B5%E3%83%96%E3%83%A2%E3%82%B8%E3%83%A5%E3%83%BC%E3%83%AB%E3%82%92%E6%9C%80%E6%96%B0%E3%81%AE%E3%83%96%E3%83%A9%E3%83%B3%E3%83%81%E3%81%AB%E3%81%99%E3%82%8B%E5%85%A8%E3%81%A6git-pull%E3%81%99%E3%82%8B">[git] 複数のリモートリポジトリを扱う&amp;サブモジュール&amp;複数のリモートリポジトリのサブモジュール - Qiita</a></li>
  <li><a href="https://qiita.com/kentarosasaki/items/3e670567c0512b9d411e">git clone の際に submodule の clone を忘れたときの対処法 - Qiita</a></li>
</ul>
