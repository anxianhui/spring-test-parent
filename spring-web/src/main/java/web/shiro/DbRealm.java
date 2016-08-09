package web.shiro;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.DisabledAccountException;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;

import com.andy.usercenter.user.model.Authority;
import com.andy.usercenter.user.model.Role;
import com.andy.usercenter.user.model.User;
import com.andy.usercenter.user.repositories.UserRepository;


public class DbRealm  extends AuthorizingRealm {
	
	@Resource
	private UserRepository userRepository;
	
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
		UsernamePasswordToken upToken = (UsernamePasswordToken) token;
		String userName = upToken.getUsername();
		SimpleAuthenticationInfo info = null;
		User user = userRepository.findByUserName(userName);
		if(!user.getIsEnabled()){
			throw new DisabledAccountException();
		}
		if (user != null) {
			String pwd = user.getUserPwd();
			String pwdSalt = user.getPwdSalt();
			info = new SimpleAuthenticationInfo(user.getId(), pwd.toCharArray(), getName());
			info.setCredentialsSalt(ByteSource.Util.bytes(pwdSalt));
		}
		return info;
	}

	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
		Long uid = (Long) getAvailablePrincipal(principals);
		User user = userRepository.findOne(uid);
		Set<Role> roles = user.getRoles();
		List<String> permissions = new ArrayList<String>();
		for (Iterator<Role> iterator = roles.iterator(); iterator.hasNext();) {
			Role role = (Role) iterator.next();
			Set<Authority> authoritys = role.getAuthoritys();
			for (Iterator<Authority> authorityIterator = authoritys.iterator(); authorityIterator.hasNext();) {
				Authority authority = (Authority) authorityIterator.next();
				permissions.add(authority.getCode());
			}
		}
		//处理权限信息，角色，权限值的处理
		SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
		info.addStringPermissions(permissions);
		return info;// TODO Auto-generated method stub
	}
	
	

}
