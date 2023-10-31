
package edusys.dao;

import edusys.helper.Jdbc;
import edusys.entity.KhoaHoc;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class KhoaHocDAO{
    public void insert(KhoaHoc model){
        String sql="INSERT INTO KhoaHoc (MaCD, HocPhi, ThoiLuong, NgayKG, GhiChu, MaNV) VALUES (?, ?, ?, ?, ?,?)";
        Jdbc.executeUpdate(sql,
        model.getMaCD(),
        model.getHocPhi(),
        model.getThoiLuong(),
        model.getNgayKG(),
        model.getGhiChu(),
        model.getMaNV());
    }
    public void update(KhoaHoc model){
        String sql="UPDATE KhoaHoc SET MaCD=?, HocPhi=?, ThoiLuong=?, NgayKG=?, GhiChu=?, MaNV=? WHERE MaKH=?";
        Jdbc.executeUpdate(sql,
            model.getMaCD(),
            model.getHocPhi(),
            model.getThoiLuong(),
            model.getNgayKG(),
            model.getGhiChu(),
            model.getMaNV(),
            model.getMaKH());
    }
    public void delete(Integer MaKH){
        String sql="DELETE FROM KhoaHoc WHERE MaKH=?";
        Jdbc.executeUpdate(sql, MaKH);
    }

    public List<KhoaHoc> select(){
        String sql="SELECT * FROM KhoaHoc";
        return select(sql);
    }

    public KhoaHoc findById(Integer makh){
        String sql="SELECT * FROM KhoaHoc WHERE MaKH=?";
        List<KhoaHoc> list = select(sql, makh);
        return list.size() > 0 ? list.get(0) : null;
    }
    
    public List<KhoaHoc> selectByChuyenDe(String macd) {
        String SQL = "SELECT * FROM KhoaHoc WHERE MaCD = ?";
        return this.select(SQL, macd);
    }
    
    public List<Integer> selectYear(){
        String sql="SELECT DISTINCT year(NgayKG) FROM KhoaHoc ORDER BY Year DESC";
        List<Integer> list = new ArrayList<>();
        try {
            ResultSet rs = Jdbc.executeQuery(sql);
            while (rs.next()) {                
                list.add(rs.getInt(1));
            }
            rs.getStatement().getConnection().close();
            return list;
        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        }
    }

    private List<KhoaHoc> select(String sql, Object...args){
        List<KhoaHoc> list=new ArrayList<>();
        try {
            ResultSet rs = null;
            try {
                rs = Jdbc.executeQuery(sql, args);
                while(rs.next()){
                    KhoaHoc model = readFromResultSet(rs);
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
    private KhoaHoc readFromResultSet(ResultSet rs) throws SQLException{
        KhoaHoc model=new KhoaHoc();
        model.setMaKH(rs.getInt("MaKH"));
        model.setHocPhi(rs.getDouble("HocPhi"));
        model.setThoiLuong(rs.getInt("ThoiLuong"));
        model.setNgayKG(rs.getDate("NgayKG"));
        model.setGhiChu(rs.getString("GhiChu"));
        model.setMaNV(rs.getString("MaNV"));
        model.setNgayTao(rs.getDate("NgayTao"));
        model.setMaCD(rs.getString("MaCD"));

        return model;
    }
}
