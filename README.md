## Voting App

###### 1-11-22
To check if a string is empty, cast it to bytes and get the length.


``` solidity
bytes(name).length != 0
```


Every mapping key exists, so to check if something has never been declared, we can set a bool property `exists`.

The array doesn't have a way to tell if something already exists, for unique array addresses use a private function with a `for-loop`


###### 1-12-22
Starting to use inheritance from a simple voting contract to a new voting contract that will handle Registration

We can call inherited functions using `super.foo()` 

If we really want to pass complex data we can use events, for example `emit(myArrayofStructs)`

###### 1-18-22

`try-catch` blocks are used only for external calls and contructor calls, these are often used for unit tests

In Remix I'm not able to assert if certain public function throws a `require()` 

To mock `msg.sender` and `msg.value` in unit tests in Remix, we should use tag comments:
``` solidity
// #sender: account-1
// #value: 10000
function fooTest() public {}
```






