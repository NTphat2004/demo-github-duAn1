
package edusys.dao;

import edusys.helper.Jdbc;
import edusys.entity.HocVien;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class HocVienDAO{
    public void insert(HocVien model){
        String sql="INSERT INTO HocVien(MaKH, MaNH, Diem) VALUES(?, ?, ?)";
        Jdbc.executeUpdate(sql,
        model.getMaKH(),
        model.getMaNH(),
        model.getDiem());
    }

//    public void update(HocVien model){
//        String sql="UPDATE HocVien SET MaKH=?, MaNH=?, Diem=? WHERE MaHV=?";
//        Jdbc.executeUpdate(sql,
//        model.getMaKH(),
//        model.getMaNH(),
//        model.getDiem(),
//        model.getMaHV());
//    }
    
        public void update(HocVien model){
        String sql="UPDATE HocVien SET Diem=? WHERE MaHV=?";
        Jdbc.executeUpdate(sql,
        model.getDiem(),
        model.getMaHV());
    }

    public void delete(Integer MaHV){
        String sql="DELETE FROM HocVien WHERE MaHV=?";
        Jdbc.executeUpdate(sql, MaHV);
    }

    public List<HocVien> select(){
        String sql="SELECT * FROM HocVien";
        return select(sql);
    }
    
    public List<HocVien> selectByKhoaHoc(int makh) {
        String SQL = "SELECT * FROM HocVien WHERE MaKH =?";
        return this.select(SQL, makh);
    }

    public HocVien findById(Integer mahv){
        String sql="SELECT * FROM HocVien WHERE MaHV=?";
        List<HocVien> list = select(sql, mahv);
        return list.size() > 0 ? list.get(0) : null;
    }
    private List<HocVien> select(String sql, Object...args){
        List<HocVien> list = new ArrayList<>();
        try {
            ResultSet rs = null;
            try {
                rs = Jdbc.executeQuery(sql, args);
                while(rs.next()){
                    HocVien model=readFromResultSet(rs);
                    list.add(model);
                }
            }
            finally{
                rs.getStatement().getConnection().close();
            }
        }
        catch (SQLException ex) {
            throw new RuntimeException(ex);
        }
        return list;
    }

    private HocVien readFromResultSet(ResultSet rs) throws SQLException{
        HocVien model=new HocVien();
        model.setMaHV(rs.getInt("MaHV"));
        model.setMaKH(rs.getInt("MaKH"));
        model.setMaNH(rs.getString("MaNH"));
        model.setDiem(rs.getDouble("Diem"));
        return model;
    }
}
