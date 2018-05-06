@isTest 
private class HelloaccountTestClass {
    static testMethod void validateHelloWorld() {
      account acc = new account();
      acc.name = 'Acctest';
      insert acc ;
    }
}