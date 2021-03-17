# WindowsTerminalSettings

## 1.以下からMicrosoft.DesktopAppInstaller(winget)をインストール

<ul>
  <li><a href="https://github.com/microsoft/winget-cli/releases">Releases · microsoft/winget-cli</a></li>
</ul>
適切なバージョンをインストール

## 2.Git・Windows Terminal Preview(WTP)・PowerShellCore(pwsh)・VSCode・VSCode-Insifersのインストール

※インストール済みの場合は、アンインストールしておくか各ステップをスキップする。※

<ul>
  <li>方法1.MicrosoftStoreアプリからインストール(WTPのみ対応)</li>
  <li>方法2.githubのreleaseページを検索してそこからインストール</li>
  <li>方法3(推奨)Wingetコマンドでインストール</li>
</ul>

推奨及びここで紹介するのは方法3

<code>WindowsTerminalSettings/windows/winget/install.ps1</code><br>
  を実行して、Git・WTP・pwsh・VSCode・VSCode-Insidersの5つをインストール

  ※すでにインストール済みだった場合は、アンインストールしてから実行する事。

  (そうでないと同じものが２つインストールされて面倒な状況になってしまうので要注意)

## 3.本リポジトリの配置

以下のコマンドを実行して、クローンの作成(要はダウンロード)を行う。

<code>git clone https://github.com/kuni3933/WindowsTerminalSettings --recursive</code>

## 4.パス設定

1. このリポジトリが配置されているパスを、ユーザー環境変数:WindowsTerminalSettings として登録

    以下、「C:/Users/ユーザー名/WindowsTerminalSettings(このリポジトリ)」という配置状況での例

    <code>ユーザー環境変数名:WindowsTerminalSettings</code><br>
    <code>ユーザー環境変数値:C:/Users/ユーザー名/WindowsTerminalSettings</code><br>

2. 今度はGitがインストールされたフォルダを、システム環境変数:GIT_INSTALL_ROOT として登録

    まずは<code>cmd /c where git</code>このコマンドを実行して、git.exeの位置を確認

   出力された位置の2階層上に位置するGitフォルダを環境変数GIT_INSTALL_ROOTとして登録する。

    <code>C:\Program Files\Git\cmd\git.exe</code>と出力されたら以下の設定<br>
    <code>システム環境変数名:GIT_INSTALL_ROOT</code><br>
    <code>システム環境変数値:C:\Program Files\Git</code><br>

## 5.フォントのインストール

1. 以下から「Source Code Pro」をダウンロードしてWindows Compatible版だけは必ずインストールする。
    <a href="https://www.nerdfonts.com/#home">Nerd Fonts - Iconic font aggregator, glyphs/icons collection, &amp; fonts patcher</a>

## 6.pwshのモジュールインストール

pwsh上で以下のコマンドを管理者権限で実行

1. <code>Install-Module posh-git -Scope CurrentUser -Force</code>
2. <code>Install-Module oh-my-posh -Scope CurrentUser -Force</code>
3. <code>Install-Module -Name PSReadLine -Scope CurrentUser -Force</code>

※以下のコマンドを実行して、セキュリティポリシーがCurrentUserのみRemoteSignedとなっていることを確認する事。

<code>Get-ExecutionPolicy -l</code>

それ以外の場合は、1番で使用したコマンドを修正入力して実行

## 7.scoopの有効化(有効化済みの場合はスキップ)

デフォルトのPowershellから以下のコマンドを管理者権限で実行

1. <code>Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force</code>
2. <code>iwr -useb get.scoop.sh | iex</code>

※以下のコマンドを実行して、セキュリティポリシーがCurrentUserのみRemoteSignedとなっていることを確認する事。

なっていなかった場合は、1番で使用したコマンドを修正入力して実行

<code>Get-ExecutionPolicy -l</code>

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
3. 各install.ps1を実行してパッケージアップデート
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
