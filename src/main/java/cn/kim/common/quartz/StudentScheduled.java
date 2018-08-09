package cn.kim.common.quartz;

import cn.kim.common.BaseData;
import cn.kim.common.eu.NameSpace;
import cn.kim.dao.BaseDao;
import com.google.common.collect.Maps;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by 余庚鑫 on 2018/8/9
 * 学生定时器
 */
@Component
public class StudentScheduled extends BaseData {

    @Autowired
    private BaseDao baseDao;

    /**
     * 每天定时撤销学生到期处分
     *
     * @throws Exception
     */
    @Scheduled(cron = "0 0 0 * * ?")
    @Transactional
    public void updatePunishmentRevoke() {
        try {
            baseDao.update(NameSpace.StudentExtendMapper, "refreshStudentRevokePunishment", null);
        } catch (Exception e) {
            e.printStackTrace();
            baseDao.rollback();
        }
    }
}
