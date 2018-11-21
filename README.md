###以太坊：

    以太坊官网：https://www.ethereum.org/
    以太坊爱好者：https://ethfans.org/
    以太坊浏览器：https://etherscan.io/
    区块链演示网站： https://anders.com/blockchain/coinbase.html
    				https://blockchaindemo.io/
    概念：
        以太坊虚拟机EVM
        认识mist 和ethereum wallet
        账户
            外部账户
                有余额，无代码
            合约账户
                由外部账户创建，有余额、有代码
                由外部账号发送消息激活合约
        交易
        gas
        以太坊框架： pop--blockchain--evm--合约
        Dapp结构图
                                数据库
                ipfs    前段      后台
                        以太坊
                最初pow   现在pow+pos
          四个阶段：
          	前沿（Frontier）家园（Homestead）大都会（Metropolise）宁静（Serenity）
    
    在线钱包使用
	1、区块链钱包：https://www.myetherwallet.com   MyEtherWallet
	2、create New Wallet
	3、保存密钥和生成地址
	4、钱包2：MetaMask  谷歌钱包  ：安装扩展程序MetaMask（此项目用这个钱包）
	5、metaMask使用  :账户新建与导入
	6、切换测试网络请求测试币  Ropsten Test Network 测试网络 //https://faucet.metamask.io/
	7、测试网络转账过程   Ropsten Test Network 测试网络
	8、faucet.ropsten.be:3001
	9、mist浏览器---钱包
	10  获取测试币

    ENS
    	类似DNS
    	地址对应名字

    ##智能合约   （尼克·萨博）
        是一套以数字形式定义的承诺（协议）承诺控制着数字资产并包含了合约参与者约定的权利和义务，由计算机系统自动执行

        作用

        整合资金流容易
        部署时与后续写入需要费用
        存储资料的成本更高
        部署后无法更改

        IDE  在线：https://remix.ethereum.org
        	连接到本地： 工具 npm install -g remixd
        					remixd -s ./    路径
        	部署合约：mist 和 remix IDE

        语言：solidity
        	官网：   https://solidity.readthedocs.io/en/develop/
            memory   storage
            import
            函数修饰符modifier、
            合约函数  internal    external
            events
            枚举

            类型 ：
            值类型
            引用类型

            bool、整型、address、string、枚举（enum）、函数、数组、结构体、map


            address 地址   20字节160位
            		uint160(地址)  //强转整型         adress(uint160)   //转地址
                    属性：balance
                        msg.sender     获取部署合约的地址
                                        调用者的地址
                        msg.value   存入合约地址的eth
                        this    this.balance        合约地址    this 就是合约本身   //转账的关键字 payable
                    方法：
                    	call()
                        send()    返回值true和falase   不抛出异常。
                        transfer()
                        AliceAddress.transfer(msg.value)
            
            函数  internal    external
            	内部函数调用  只能那内部调用
            	调用external时用this关键字，相当于外部调用
            	继承关键字  is

            数组：
            	定长数组：bytes2   不可修改，长度不可修改
            	不定长数组： 类型[]  bytes  string
            		memory storage
            		类型[]  memory  可以修改值，不可修改长度、不可以push   用new创建
            		类型[]  storage  可以修改值，可修改长度、可以push       用new创建
            		bytes   引用类型  可以修改值，可以修改长度，可以push   用new创建
            		string  特殊的可变字节数组  引用类型，不支持修改    
            				需转为bytes 修改

            结构体
            	引用类型
            常量：constant   修饰值类型和string
                    constant 修饰的函数内，如果修改了状态变量，那么状态变量的值是无法改变的，不报错
                view 只可以修饰函数 == constant  修饰函数时，只可以对storage类型的变量进行读取，无法修改
                    不可以修改变量
                pure   只可以修饰函数，表示函数内无法读写状态变量

            var
            	自动推导类型

            全局函数 变量
            	now
            	block.blockhash()
            	block.coinbase
            	block.difficulty
            	block.timestamp
            	msg.data
            	msg.gas
            	msg.sender
            	msg.sig
            	msg.value
            	tx.gasprice
            	tx.origin

            时间单位和货币单位

            错误处理
                require()
                assert()
                revert()
            delete介绍
                delete   //操作任何变量，除了map，                将其设置为默认值
                            可以删除map里的元素
                    动态数组、静态数组

            修饰器 
                modifier   是一种合约属性
                _;  //代表修饰器所修饰的函数的代码


    geth搭建私有链
    	geth     go版本的客户端
    	网络
    		主网络
    		测试网络
    		开发网络
    		私有网络

    		创建私有网络
    		准备genesis.json
    			{
					"alloc" : {},
					"config" :{
				 		"chainID" : 72,
				 		"homwsteadBlock" : 0,
				 		"eip155Block": 0,
				 		"eip158Block": 0
					},
					"nonce" : "0x0000000000000042",
					"difficulty": "0x4000",
					"mixhash": "0x0000000000000000000000000000000000000000000000000000000000000000",
					"coinbase":"0x0000000000000000000000000000000000000000",
					"timestamp":"0x00",
					"parentHash":"0x0000000000000000000000000000000000000000000000000000000000000000",
					"extraData":"0x00000000",
					"gasLimit":"0xffffffff"
				}

			创建文件夹放入genesis.json

			创建节点  geth --datadir node1 init genesis.json
			启动私有连节点  geth -datadir node1 --networkid 72 --port 3100 console
				可以允许模块指令
				admin:1.0 debug:1.0 eth:1.0 ethash:1.0 miner:1.0 net:1.0 personal:1.0 rpc:1.0 txpool:1.0 web3:1.0
        geth datadir D:\learn\eth\myprivateNet\node1   init  json
        geth --datadir "./node1" --networkid 72 --port 30301 --ipcpath \\.\pipe\geth.ipc

        geth attach ipc:\\.\pipe\geth.ipc

        	可以进行以太坊指令
        	personal.newAccount("1111")
        	eth.acounts

        	创建多个节点
        		进行交易

        	启动EHT钱包
        		admin.nodeInfo.enode
        			获取节点信息
        				"enode://68973c87e2b05091603ccf42581da1214408ab489665af42498043f8a72af845151e3f89ac87846e697f233c60bc563165caa98dc7b2a328c1a5625f9232e570@100.123.73.42:3100?discport=0"
        					修改为真实ip

        		admin.addPeer(节点信息)


        truffle 开发
        	世界级的以太坊开发框架
        	官网：https://truffleframework.com/

        						  json-rpc                         geth   truffle
        		web3.jd   <========================>			以太坊客户端      ---------------------------> 以太坊网络
        			浏览器                                         智能合约                                     节点

        		web3.js
        		bigNumber

        		web3 编译 abi 部署at 调用call
        		remix 自动编译 实例

        	使用truffle进行
        		truffle init
        		truffle compile
        				启动以太坊网络 truffle develop
        		truffle migrate   

        		Ganache （图形界面）



        		netstat -ano | findstr "3100"

