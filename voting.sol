pragma solidity ^0.4.24;
pragma experimental ABIEncoderV2;   //字符串切片需要

contract VoteContract {

  //定义投票者结构体
  struct Voter {
    uint voteNumber;  //投票的编号号
    bool isVoted;  // 是否投过票
    uint weight;    //权重
    address delegate;   //代理人地址
  }

  //定义候选人结构体
  struct Candidate {
    string name;     //候选人名字
    uint voteCount; //获得的票数
  }

  //部署合约的地址
  address public admin;

  //候选人数组，和投票者map
  Candidate[] public candidates;
  mapping (address => Voter) voters;  //key 为地址

  //构造函数
  constructor(string[] candidatesNames) public{
    admin = msg.sender;//admin   当前账户地址
      //获取初始化候选人名额，放入候选人数组中
    for (uint i = 0;i<candidatesNames.length;i++){
      Candidate memory tmp = Candidate({name:candidatesNames[i],voteCount:0});
      candidates.push(tmp);
    }
  }

//修饰器，当前账户= 部署合约账户才可以执行
  modifier adminOnly(){
    require(admin == msg.sender);// 当前账户= 部署合约账户才可以执行
    _;
  }

  //赋予投票权
  function giveVoteRightTo(address addr) adminOnly public{
    if (voters[addr].weight > 0)  //判断是否已经赋值过
    revert();
    //添加投票人mapping
    voters[addr].weight =1;
  }

  //投票
  function vote(uint voteNum)public{
    //当前投票人
    Voter storage voter = voters[msg.sender];
    //判断有无投票权和是否投过票
    if(voter.weight <= 0 || voter.isVoted)
    revert();
    //投票
    voter.isVoted = true;
    voter.voteNumber = voteNum;
    candidates[voteNum].voteCount += voter.weight;
  }

  //选择代理
  function delegateFunc(address to) public{
    //当前投票人
    Voter storage voter = voters[msg.sender];
    //判断有无投票权和是否投过票
    if(voter.weight <= 0 || voter.isVoted)
    revert();
    //判断选择的代理不能为自己，否则进入死循环
    //代理人也选择了代理则进行轮询
    while (voters[to].delegate != address(0) && voters[to].delegate != msg.sender){
      to = voters[to].delegate;  //轮询
    }
    require(msg.sender != to);//轮询最终不是自己

    voter.isVoted  = true;
    voter.delegate = to;
    //获取最后代理人
    Voter storage finalDelegateVoter = voters[to];

    //判断代理是否已经投票
    //已经投票则进行把票投个他投的候选人
    //否则把代理人的权重+1
    if(finalDelegateVoter.isVoted){
      candidates[finalDelegateVoter.voteNumber].voteCount += voter.weight;
    }else{
      finalDelegateVoter.weight += voter.weight;
    }
  }


  //获得候选人的票数


  //判断谁获胜
  function whoWin() view public returns (string,uint) {

    string memory winner;
    uint winnerVoteCount;
    //循环比较候选人的connt
    for (uint i =0; i<candidates.length;i++){
      if(candidates[i].voteCount > winnerVoteCount){
      winnerVoteCount = candidates[i].voteCount;
      winner = candidates[i].name;
      }
    }
    return (winner,winnerVoteCount);
  }

}
