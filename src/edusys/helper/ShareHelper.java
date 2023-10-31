
package edusys.helper;
import edusys.entity.NhanVien;
import java.awt.Image;
import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import javax.swing.ImageIcon;

public class ShareHelper {
    //Thêm Logo Ứng Dụng
    public static final Image APP_ICON;
    static{
        String file = "/edusys/icon/images/fpt.png";
        APP_ICON = new ImageIcon(ShareHelper.class.getResource(file)).getImage();
    }
    
    //sao chép file logo vào mục logo chuyên đề
    public static boolean saveLogo(File file){
        File dir = new File("logos");
        //tạo thư mục nếu không có
        if (!dir.exists()) {
            dir.mkdirs();
        }
        File newFile = new File(dir, file.getName());
        try {
            //sao chép vào thư mục logos
            Path source = Paths.get(file.getAbsolutePath());
            Path destination = Paths.get(newFile.getAbsolutePath());
            Files.copy(source, destination, StandardCopyOption.REPLACE_EXISTING);
            return true;
        } catch (Exception ex) {
            return false;
        }
    }
    
    //đọc hình ảnh trong logo chuyên đề
    public static ImageIcon readLogo(String fileName){
        File path = new File("logos", fileName);
        return new ImageIcon(path.getAbsolutePath());
    }
    
     //Đối tượng này chứa thông tin người sử dụng sau khi đăng nhập
     public static NhanVien USER = null;
     
     //Xóa thông tin của người sử dụng khi có yêu cầu đăng xuất
     public static void logoff() {
     ShareHelper.USER = null;
     }
     
    //Kiểm tra xem đăng nhập hay chưa
    //@return đăng nhập hay chưa
    public static boolean authenticated() {
    return ShareHelper.USER != null;
    }
    
    
}
