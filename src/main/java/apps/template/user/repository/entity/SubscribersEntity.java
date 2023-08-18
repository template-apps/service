package apps.template.user.repository.entity;

import jakarta.persistence.*;

import java.util.Objects;

@Entity
@Table(name = "subscribers")
public class SubscribersEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String email;

    public SubscribersEntity() {
    }

    public SubscribersEntity(final String email) {
        this.email = email;
    }

    @Column(name = "id")
    public Long getId() {
        return id;
    }

    public void setId(final Long id) {
        this.id = id;
    }

    @Column(name = "email")
    public String getEmail() {
        return email;
    }

    public void setEmail(final String email) {
        this.email = email;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        SubscribersEntity that = (SubscribersEntity) o;
        return Objects.equals(id, that.id) && Objects.equals(email, that.email);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, email);
    }

    @Override
    public String toString() {
        return "SubscribersEntity{" +
                "id=" + id +
                ", email='" + email + '\'' +
                '}';
    }
}

