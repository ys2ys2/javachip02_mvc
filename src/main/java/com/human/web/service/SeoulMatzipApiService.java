package com.human.web.service;


import java.util.List;

import com.human.web.vo.SeoulMatzipApiVO.Row;

public interface SeoulMatzipApiService {
	List<Row> getAllSeoulMatzip();
	int insertSeoul();
}