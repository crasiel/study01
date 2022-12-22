package kr.board.config;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

// root-context.xml
@Configuration
@MapperScan(basePackages = {"kr.board.mapper"})		// 여러개인 경우 {"", "", "",....}
@PropertySource({"classpath:persistence-mysql.properties"})		//  src/main/resources 폴더에서 해당 파일 가져옴
public class RootConfig {
	@Autowired private Environment env;
	
	@Bean
	public DataSource myDataSource() {
		HikariConfig hikariConfig = new HikariConfig();
		hikariConfig.setDriverClassName(env.getProperty("jdbc.dirver"));
		hikariConfig.setJdbcUrl(env.getProperty("jdbc.url"));
		hikariConfig.setUsername(env.getProperty("jdbc.user"));
		hikariConfig.setPassword(env.getProperty("jdbc.password"));
		
		HikariDataSource myDataSource = new HikariDataSource(hikariConfig);
		return myDataSource;
	}
	
	@Bean
	public SqlSessionFactory sessionFactory() throws Exception {
		// mybatis에서 사용하가 위한 connectionPool 만들어서 sqlsessionfactory 타입으로 반환
		SqlSessionFactoryBean sessionFactory = new SqlSessionFactoryBean();
		sessionFactory.setDataSource(myDataSource());
		return (SqlSessionFactory) sessionFactory.getObject();
	}
}
