package com.human.web.service;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.human.web.repository.BannerPlaceDAO;

@Service
public class BannerPlaceServiceImpl implements BannerPlaceService {

	@Autowired
	private BannerPlaceDAO bannerPlaceDAO;

	@Override
	public List<Map<String, Object>> getRandomBannerPlace(int limit) {
		// DB에서 랜덤으로 배너 데이터를 가져옴
		List<Map<String, Object>> bannerPlaces = bannerPlaceDAO.getRandomBannerPlace(limit);

		// firstimage 필드에서 첫 번째 이미지 URL만 남기기
		return bannerPlaces.stream().map(bannerPlace -> {
			String firstimage = (String) bannerPlace.get("firstimage");
			if (firstimage != null && firstimage.contains(",")) {
				// 쉼표로 구분된 이미지 중 첫 번째만 추출
				firstimage = firstimage.split(",")[0].trim();
			}
			bannerPlace.put("firstimage", firstimage);
			return bannerPlace;
		}).collect(Collectors.toList());
	}

	@Override
	public Map<String, Object> getBannerById(int contentid) {
		return bannerPlaceDAO.getBannerById(contentid);
	}

	// areacode로 배너 목록 가져오기
	@Override
	public List<Map<String, Object>> getBannersByAreaCode(String areacode) {
		List<Map<String, Object>> bannersByAreaCode = bannerPlaceDAO.getBannersByAreaCode(areacode);

		// firstimage 처리
		return bannersByAreaCode.stream().map(bannerPlace -> {
			String firstimage = (String) bannerPlace.get("firstimage");
			if (firstimage != null && firstimage.contains(",")) {
				// 쉼표로 구분된 이미지 중 첫번째만 추출
				firstimage = firstimage.split(",")[0].trim();
			}
			bannerPlace.put("firstimage", firstimage);

			// areacode를 한글 지역명 변환하기 전 값
			String rawAreaCode = (String) bannerPlace.get("areacode");

			// areacode를 한글 지역명으로 변환하기
			String areaName = convertAreaCodeToName((String) bannerPlace.get("areacode"));
			bannerPlace.put("areacode", areaName); // areacode를 지역 이름으로 변환해서 저장
			return bannerPlace;
		}).collect(Collectors.toList());
	}

	// areacode 지역명 변환 메서드 (배너 목록 가져올때 같이 사용)
	@Override
	public String convertAreaCodeToName(String areacode) {
		if (areacode == null || areacode.isEmpty()) {
			return "알 수 없는 지역";
		}
		switch (areacode) {
			case "1":
				return "서울";
			case "2":
				return "인천";
			case "3":
				return "대전";
			case "4":
				return "대구";
			case "5":
				return "광주";
			case "6":
				return "부산";
			case "7":
				return "울산";
			case "8":
				return "세종";
			case "31":
				return "경기";
			case "32":
				return "강원";
			case "33":
				return "충북";
			case "34":
				return "충남";
			case "35":
				return "경북";
			case "36":
				return "경남";
			case "37":
				return "전북";
			case "38":
				return "전남";
			case "39":
				return "제주";
			default:
				return "알 수 없는 지역";
		}
	}
}
