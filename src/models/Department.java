package models;

import java.sql.Date;
import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
/*import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;*/
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Table(name = "departments")
@NamedQueries({
    @NamedQuery(
            name = "getAllDepartments",
            query = "SELECT d FROM Department AS d ORDER BY d.id DESC"
            ),
    @NamedQuery(
            name = "getDepartmentsCount",
            query = "SELECT COUNT(d) FROM Department AS d"
            ),
   /* @NamedQuery(
            name = "getMyAllDepartments",
            query = "SELECT d FROM Department AS d WHERE d.employee = :employee ORDER BY d.id DESC"
            ),
    @NamedQuery(
            name = "getMyDepartmentsCount",
            query = "SELECT COUNT(d) FROM Department AS d WHERE d.employee = :employee"
            ),*/

})
@Entity
public class Department {
    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

   /* @ManyToOne
    @JoinColumn(name = "employee_id", nullable = false)
    private Employee employee;*/

    @Column(name = "department_date", nullable = false)
    private Date department_date;

    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "created_at", nullable = false)
    private Timestamp created_at;

    @Column(name = "updated_at", nullable = false)
    private Timestamp updated_at;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

   /*public Employee getEmployee() {
        return employee;
    }

    public void setEmployee(Employee employee) {
        this.employee = employee;
    }*/

    public Date getDepartment_date() {
        return department_date;
    }

    public void setDepartment_date(Date department_date) {
        this.department_date = department_date;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Timestamp getCreated_at() {
        return created_at;
    }

    public void setCreated_at(Timestamp created_at) {
        this.created_at = created_at;
    }

    public Timestamp getUpdated_at() {
        return updated_at;
    }

    public void setUpdated_at(Timestamp updated_at) {
        this.updated_at = updated_at;
    }
}