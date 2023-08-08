package apps.template.user.repository;

import apps.template.user.repository.entity.UserInfoEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserInfoRepository extends JpaRepository<UserInfoEntity, Long> {
	UserInfoEntity findByEmail( String email );
}
