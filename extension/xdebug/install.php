<?php
class XdebugExtInstaller extends ExtInstaller{

    /**
     * extension name
     * eg: apcu mysql pdo_mysql ...
     */
    protected $extName = 'xdebug';
    
    /**
     * eg: https://github.com/swoole/swoole-src/archive/v1.10.5.tar.gz
     */
    protected $extSourceUrl = "https://github.com/xdebug/xdebug/archive/XDEBUG_2_5_5.tar.gz";

    /**
     * the dir of extracted source file
     * eg: swoole-src-1.10.5
     */
    protected $extNameExtracted = "xdebug-XDEBUG_2_5_5";

    /**
     * the filename of ini file
     * Nullable
     */
    protected $extIniFileName = '';

    /**
     * filename of source file downloaded
     * Nullable
     */
    protected $extSourceName = "";
    
    /**
     * set params in command of ./configure
     * @var string[]
     * Nullable
     */
    protected $extConfigureParams = [];

    /**
     * set options in ini file
     * @var string[]
     * Nullable
     */
    protected $optionParams = [];
    
    protected function getCurrentPath()
    {
        return __DIR__ ;
    }

    protected function beforeInstall()
    {

    }

    protected function beforeSetOption()
    {

        $this->optionParams[]= '[XDebug]';
        $this->optionParams[]= 'xdebug.enable=1';
        $this->optionParams[]= 'xdebug.remote_enable=1';
        $this->optionParams[]= 'xdebug.idekey=PHPSTORM';
        $this->optionParams[]= 'xdebug.remote_host='.getenv('XDEUBG_REMOTE_HOST');
        $this->optionParams[]= 'xdebug.remote_port='.getenv("XDEUBG_REMOTE_PORT");
        $this->optionParams[]= 'xdebug.remote_log=/var/log/php/xdebug_remote.log';
    }

    protected function beforeExtract()
    {

    }
}