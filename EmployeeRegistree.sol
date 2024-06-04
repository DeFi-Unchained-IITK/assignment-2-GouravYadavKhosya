// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract EmployeeRegistree{
    struct Employee{
    uint id;
    string name;
    string position;
    uint salary;
    }
    mapping(uint => Employee) public employees;
    uint public nextid;
    event EmployeeAdded(uint id, string name, string position, uint salary);
    event EmployeeUpdated(uint id, string name, string position, uint salary);
    event EmployeeDeleted(uint id, string name, string position, uint salary);

    constructor(){
       nextid = 1;
    }

    function addEmployee(string memory _name, string memory _position, uint _salary) public {
        Employee storage newEmployee = employees[nextid];
        newEmployee.id = nextid;
        newEmployee.name = _name;
        newEmployee.position = _position;
        newEmployee.salary = _salary;
        emit EmployeeAdded(nextid, _name, _position, _salary);
        nextid++;
    }

    function updateEmployee(uint _id, string memory _name, string memory _position, uint _salary) public {
        require(employees[_id].id!= 0, "Employee does not exist");
        Employee storage employee = employees[_id];
        employee.name = _name;
        employee.position = _position;
        employee.salary = _salary;
        emit EmployeeUpdated(_id, _name, _position, _salary);
   }

   function getEmployeeDetails(uint _id) public view returns (string memory, string memory, uint) {
        require(employees[_id].id!= 0, "Employee does not exist");
        Employee storage employee = employees[_id];
        return (employee.name, employee.position, employee.salary);
    }
    function deleteEmployee(uint _id) public {
        require(employees[_id].id!= 0, "Employee does not exist");
        Employee storage employee = employees[_id];
        emit EmployeeDeleted(_id, employee.name, employee.position, employee.salary);
        delete employees[_id];
    }

}