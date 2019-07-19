pragma solidity >= 0.5.8;

contract Election {
  // Model a Candidate
  struct Candidate {
    uint id;
    string name;
    uint voteCount;
  }

  // Constructor
  constructor () public {
    addCandidate("Candidate 1");
    addCandidate("Candidate 2");
  }

  event votedEvent(uint indexed _candidateId);

  // Read/write candidates
  mapping(uint => Candidate) public candidates;

  // Store accounts that have voted
  mapping(address => bool) public voters;

  // Store Candidates count
  uint public candidatesCount;

  function addCandidate(string memory _name) private {
    candidatesCount ++;
    candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
  }

  function vote(uint _candidateId) public {
    // require that they haven't voted before
    require(!voters[msg.sender], "has already voted before");

    // require a valid candidate
    require(_candidateId > 0 && _candidateId <= candidatesCount, "invalid candidate");

    // record that voter has voted
    voters[msg.sender] = true;

    // update candidate vote Count
    candidates[_candidateId].voteCount ++;

    // trigger voted event
    emit votedEvent(_candidateId);
  }
}