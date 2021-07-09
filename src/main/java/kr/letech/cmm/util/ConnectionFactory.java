package kr.letech.cmm.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

import javax.sql.DataSource;

import org.apache.commons.dbcp.DriverManagerConnectionFactory;
import org.apache.commons.dbcp.PoolableConnection;
import org.apache.commons.dbcp.PoolableConnectionFactory;
import org.apache.commons.dbcp.PoolingDataSource;
import org.apache.commons.pool.impl.GenericObjectPool;

/**
 * ERROR LOG를 DATABASE에 쌓기위한 CONNECTION
 * @author KimJungWon
 * 최초 작성일자	2017. 1. 20
 * 최초 작성자	김중원
 */
public class ConnectionFactory {
	private static interface Singleton{
		final ConnectionFactory INSTANCSE = new ConnectionFactory();
	}
	
	private final DataSource dataSource;
	
	private ConnectionFactory(){
		Properties properties = new Properties();
		properties.setProperty("user", EgovProperties.getProperty("Globals.UserName"));
		properties.setProperty("password", EgovProperties.getProperty("Globals.Password"));
		
		try {
			loadDriver("oracle.jdbc.OracleDriver");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

//		GenericObjectPool<PoolableConnection> pool = new GenericObjectPool<PoolableConnection>();
		GenericObjectPool pool = new GenericObjectPool();
		DriverManagerConnectionFactory conntionFactory = new DriverManagerConnectionFactory("jdbc:oracle:thin:@10.10.250.200:1521:xe", properties);
//		DriverManagerConnectionFactory conntionFactory = new DriverManagerConnectionFactory("jdbc:oracle:thin:@10.10.250.200:1521:orcl", EgovProperties.getProperty("Globals.UserName"), EgovProperties.getProperty("Globals.Password"));
		
		new PoolableConnectionFactory(conntionFactory, pool, null, "SELECT 1", 3, false, false, Connection.TRANSACTION_READ_COMMITTED);
		this.dataSource = new PoolingDataSource(pool);
	}
	
	public static Connection getDataBaseConnection() throws SQLException{
		return Singleton.INSTANCSE.dataSource.getConnection();
	}

	private static void loadDriver(String driver) throws SQLException{
		try {
			Class.forName(driver).newInstance();
		} catch (Exception e) {
			throw new SQLException("Unable to load driver: "+ driver);
		}
	}
	
}
