package com.springapp.mvc.service;

import com.springapp.mvc.domain.UsersEntity;
import com.springapp.mvc.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Collection;


@Service("userDetailsService")
public class UserDetailsServiceImpl implements UserDetailsService {

    @Autowired
    private UserRepository userDao;

    @Override
    @Transactional(readOnly = true)
    public UserDetails loadUserByUsername(String username)
            throws UsernameNotFoundException {
        UsersEntity user = userDao.findUserByEmail(username); //our own User model class

        if (user != null) {
            String password = user.getPassword();
            //additional information on the security object

            boolean flag;

            flag = (user.getStatus() == 1) ? true : false;

            boolean enabled = flag;
            boolean accountNonExpired = flag;
            boolean credentialsNonExpired = flag;
            boolean accountNonLocked = flag;

            //Let's populate user roles
            Collection<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
            authorities.add(new SimpleGrantedAuthority(user.getRulesEntity().getNamerule()));
            //Now let's create Spring Security User object
            org.springframework.security.core.userdetails.User securityUser = new
                    org.springframework.security.core.userdetails.User(username, password, enabled, accountNonExpired, credentialsNonExpired, accountNonLocked, authorities);
            return securityUser;
        } else {
            throw new UsernameNotFoundException("User Not Found!!!");
        }
    }

}
