package apps.template.user.repository;

import apps.template.user.repository.entity.SubscribersEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface SubscribersRepository extends JpaRepository<SubscribersEntity, Long> {
    SubscribersEntity findByEmail(String email);
}
