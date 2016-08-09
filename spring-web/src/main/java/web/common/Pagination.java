package web.common;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Pagination<T> {
	public static final Integer DEFAULT_ROWS = Integer.valueOf(10);

	private Integer page = Integer.valueOf(1);

	private Integer rows = DEFAULT_ROWS;

	private Long total = Long.valueOf(0L);

	private Integer begin = Integer.valueOf(0);

	private List<T> result;

	private Map<String, String> queryParams = new HashMap();

	public Integer getPage() {
		return this.page;
	}

	public void setPage(Integer page) {
		this.page = page;
	}

	public Integer getRows() {
		return this.rows;
	}

	public void setRows(Integer rows) {
		this.rows = rows;
	}

	public Long getTotal() {
		return this.total;
	}

	public void setTotal(Long total) {
		this.total = total;
	}

	public Integer getBegin() {
		this.begin = Integer.valueOf((this.page.intValue() - 1) * this.rows.intValue());
		return this.begin;
	}

	public void setBegin(Integer begin) {
		this.begin = begin;
	}

	public List<T> getResult() {
		return this.result;
	}

	public void setResult(List<T> result) {
		this.result = result;
	}

	public Map<String, String> getQueryParams() {
		return this.queryParams;
	}

	public void setQueryParams(Map<String, String> queryParams) {
		this.queryParams = queryParams;
	}
}