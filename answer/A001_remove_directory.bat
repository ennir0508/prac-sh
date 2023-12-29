@REM ファイル読み込み時に出力しない
@REM UTF-8
@echo off && chcp 65001 > nul

REM ========================================
REM ディレクトリ削除の練習
REM ========================================

REM 変数定義
@REM ~dp0 ... カレントディレクトリ
@REM 参考: https://learn.microsoft.com/ja-jp/windows-server/administration/windows-commands/call#batch-parameters 
set root_dir=%~dp0\..\

REM ログファイル配置ディレクトリ
set log_dir=%root_dir%\log\

REM YYYYMMDD
set now=%date:~0,4%%date:~5,2%%date:~8,2%

REM ログファイル
set log_filename=prac0001_%now%.log

REM 作業ディレクトリ
set work_dir=%root_dir%\work\

REM テストディレクトリ
set test_dir=%work_dir%\test\

REM メイン処理 ~開始~
REM 作業ディレクトリが存在しない場合、作成する
if not exist %work_dir% (
    call :warn "The work folder dosen't exist."
    mkdir %work_dir%
    call :log "The work folder has been created."
)

REM ログファイル配置ディレクトリが存在しない場合、作成する
if not exist %log_dir% (
    call :warn "The log folder dosen't exist."
    mkdir %log_dir%
    call :log "The log folder has been created."
)

if not exist %test_dir% (
    REM testディレクトリが存在しない場合、作成する
    mkdir %test_dir%
    call :log "The test folder has been created."
) else (
    REM testディレクトリが存在する場合、削除する
    call :warn "The test folder already exists."
    
    @REM rmdir ... ディレクトリ削除
    @REM    /s ... 再帰的に削除する
    @REM    /q ... 確認メッセージを表示しない
    rmdir /s /q %test_dir%
    call :log "The test folder has been deleted."
)

REM メイン処理 ~終了~
@REM ここで終了しない場合,以降のサブルーチン定義処理が呼び出されてしまう
exit /b

REM サブルーチン定義

@REM サブルーチン(関数)
@REM
@REM 書き方: 呼び出し
@REM   call : サブルーチン名 [引数]
@REM
@REM 書き方: 定義
@REM   :サブルーチン名
@REM   処理
@REM   exit /b [数値]
@REM
@REM 参考: https://itsakura.com/windows-bat-kansuu

REM ログ出力 
:log
  @REM date 日付コマンド(YYYY/MM/DD)
  @REM time 時刻コマンド(hh:mm:ss)
  echo [%date% %time%]: %~nx0 [INFO] %~1 >> %log_dir%\%log_filename%
exit /b 

REM 警告出力 
:warn
  echo [%date% %time%]: %~nx0 [WARN] %~1 >> %log_dir%\%log_filename%
exit /b 

REM エラー出力 
:error
  echo [%date% %time%]: %~nx0 [ERROR] %~1 >> %log_dir%\%log_filename%
exit /b 
