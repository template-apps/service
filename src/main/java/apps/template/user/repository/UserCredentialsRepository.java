package apps.template.user.repository;

import apps.template.user.repository.entity.UserCredentialsEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserCredentialsRepository extends JpaRepository<UserCredentialsEntity, Long> {
	UserCredentialsEntity findByUserId( Long userId );
}
