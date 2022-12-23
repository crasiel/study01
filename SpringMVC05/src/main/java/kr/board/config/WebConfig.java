package kr.board.config;
import javax.servlet.Filter;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;
// web.xml
public class WebConfig extends AbstractAnnotationConfigDispatcherServletInitializer {

	
	@Override
	protected Filter[] getServletFilters() {
		// 한글 인코딩 filter 설정
		CharacterEncodingFilter encodingFilter = new CharacterEncodingFilter();
		encodingFilter.setEncoding("UTF-8");
		encodingFilter.setForceEncoding(true);
		return new Filter[] { encodingFilter };
	}

	@Override
	protected Class<?>[] getRootConfigClasses() {
		// root-context.xml -> RootConfig.class
		return new Class[] { RootConfig.class, SecurityConfig.class };
	}

	@Override
	protected Class<?>[] getServletConfigClasses() {
		// servlet-context.xml -> ServletConfig.class
		return new Class[] { ServletConfig.class };
	}

	@Override
	protected String[] getServletMappings() {
		// 경로 ("/")
		return new String[] { "/" };
	}

}
