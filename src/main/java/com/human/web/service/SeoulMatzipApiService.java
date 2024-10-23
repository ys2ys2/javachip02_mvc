package com.human.web.service;


import com.human.web.vo.SeoulMatzipApiVO.Row;
import java.util.List;

public interface SeoulMatzipApiService {
	List<Row> getAllSeoulMatzip();
	int insertSeoul();
}